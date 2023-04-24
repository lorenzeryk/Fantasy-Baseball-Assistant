//
//  PlayerValidation.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 4/22/23.
//

import Foundation

extension DataRequester {
    func validatePlayer(first_name: String, last_name: String, team: Team, primary_position: String) async -> String? {
        let returnedPlayers: ReturnedTeamProfile? = await getTeamProfilePlayers(team: team)
        
        guard let players = returnedPlayers?.players else {
            print("No players returned in team profile")
            return nil
        }
        
        guard players.count != 0 else {
            print("No players in array of players")
            return nil
        }
        
        for player in players {
            if ((player.first_name == first_name || player.preferred_name == first_name) && player.last_name == last_name && player.primary_position == primary_position) {
                print("Player found")
                return player.id
            }
        }
        print("Player not found")
        return nil
    }
    
    private func getTeamProfilePlayers(team: Team) async -> ReturnedTeamProfile? {
        let fetchProfileTask = Task { () -> ReturnedTeamProfile? in
            let full_url = "\(base_url)/teams/\(team.teamID)/profile.json?api_key=\(api_key)"
            guard let url = URL(string: full_url) else {
                return nil
            }

            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            let data: Data
            let response: URLResponse
            
            do {
                (data, response) = try await URLSession.shared.data(from: url)
            } catch {
                print("Error requesting team profile for \(team): \(error)")
                return nil
            }

            let httpResponse = response as? HTTPURLResponse
            if (httpResponse?.statusCode != 200) {
                print("Recieved \(httpResponse?.statusCode ?? 0) from server")
                if let errorCode = httpResponse?.value(forHTTPHeaderField: "X-Mashery-Error-Code") as? String {
                    if (errorCode == "ERR_403_DEVELOPER_OVER_QPS") {
                        throw responseError.overQPS
                    }
                }
                return nil
            }
            
            do {
                return try JSONDecoder().decode(ReturnedTeamProfile.self, from: data)
            } catch {
                print("Failed to convert JSON")
                return nil
            }
        }
        
        for _ in 0..<num_retries {
            do {
                return try await fetchProfileTask.result.get()
            } catch responseError.overQPS {
                let sleepTime = Int.random(in: min_sleep_retry...max_sleep_retry)
                print("Retry fetching team profile in \(sleepTime)")
                sleep(UInt32(sleepTime))
            } catch {
                return nil
            }
        }
        return nil
    }
}
