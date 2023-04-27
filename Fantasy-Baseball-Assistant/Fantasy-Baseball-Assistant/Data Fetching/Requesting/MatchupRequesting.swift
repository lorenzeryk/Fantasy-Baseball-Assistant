//
//  MatchupRequesting.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 4/22/23.
//

import Foundation
import CoreData

extension DataRequester {
    /// Requests all matchups across the league for today
    ///
    /// Requests matchups across the league today. If the request fails due to an Over Query Per Seconds Error then the request is retried the set number of times with a sleep of a random value between the set max and min times.
    ///
    /// - Parameters:
    ///     - persistenceController: The instance of the Persistence Controller used throughout the application
    ///
    /// - Returns: An array of matchups or an empty array if the matchups could not be requested
    func getMatchupData(peristenceController: PersistenceController) async -> [Matchup] {
        print("Requesting matchup")
        let matchupData: ReturnedMatchup? = await requestMatchupData()
        
        guard matchupData?.league?.games != nil else {
            print("Failed to request matchup data")
            return []
        }
        
        var matchups: [Matchup] = []
        
        for returnedMatchup in matchupData!.league!.games! {
            let date = convertToDate(returnedMatchup.game?.scheduled)
            let weather = WeatherInfo(condition: returnedMatchup.game?.weather?.forecast?.condition, temp: returnedMatchup.game?.weather?.forecast?.temp_f, entity: peristenceController.getDescription(entityName: "WeatherInfo")!, context: peristenceController.container.viewContext)
            let home_team = TeamMatchupData(id: returnedMatchup.game?.home?.id, win: returnedMatchup.game?.home?.win, loss: returnedMatchup.game?.home?.loss, startingPlayers: returnedMatchup.game?.home?.lineup, entity: peristenceController.getDescription(entityName: "TeamMatchupData")!, context: peristenceController.container.viewContext)
            let away_team = TeamMatchupData(id: returnedMatchup.game?.away?.id, win: returnedMatchup.game?.away?.win, loss: returnedMatchup.game?.away?.loss, startingPlayers: returnedMatchup.game?.away?.lineup, entity: peristenceController.getDescription(entityName: "TeamMatchupData")!, context: peristenceController.container.viewContext)
            
            matchups.append(Matchup(date: date ?? Date(), home_team: returnedMatchup.game?.home_team ?? "", away_team: returnedMatchup.game?.away_team ?? "", weather: weather, home_team_info: home_team, away_team_info: away_team, entity: peristenceController.getDescription(entityName: "Matchup")!, context: peristenceController.container.viewContext))
        }
        
        return matchups
    }
    
    private func requestMatchupData() async -> ReturnedMatchup? {
        let matchupFetchTask = Task { () -> ReturnedMatchup? in
            let full_url = "\(base_url)/games/\(getCurrentDate())/summary.json?api_key=\(api_key)"
            
            guard let url = URL(string: full_url) else {
                return nil
            }
            
            let data: Data
            let response: URLResponse
            
            do {
                (data, response) = try await URLSession.shared.data(from: url)
            } catch {
                print("Error requesting matchup data: \(error)")
                return nil
            }
            
            let httpResponse = response as? HTTPURLResponse
            if (httpResponse?.statusCode != 200) {
                print("Recieved \(httpResponse?.statusCode ?? 0) from server")
                if let errorCode = httpResponse?.value(forHTTPHeaderField: "X-Mashery-Error-Code") as? String {
                    if (errorCode == "ERR_403_DEVELOPER_OVER_QPS") {
                        print("Initiate retry")
                        throw responseError.overQPS
                    }
                }
                return nil
            }
            
            do {
                return try JSONDecoder().decode(ReturnedMatchup.self, from: data)
            } catch {
                print("Failed to convert JSON: \(error)")
                return nil
            }
        }
        
        for _ in 0..<num_retries {
            do {
                return try await matchupFetchTask.result.get()
            } catch responseError.overQPS {
                let sleepTime = Int.random(in: min_sleep_retry...max_sleep_retry)
                print("Retry fetching matchup data in \(sleepTime)")
                sleep(UInt32(sleepTime))
            } catch {
                return nil
            }
        }
        return nil
    }
    
    private func getCurrentDate() -> String {
        let date = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        
        let monthString = (month < 10) ? "0\(month)" : "\(month)"
        let dayString = (day < 10) ? "0\(day)" : "\(day)"
        
        return "\(year)/\(monthString)/\(dayString)"
    }
    
    private func convertToDate(_ date: String?) -> Date? {
        guard date != nil else {
            return nil
        }
        
        let dateFormatter = ISO8601DateFormatter()
        return dateFormatter.date(from: date!)
    }
}
