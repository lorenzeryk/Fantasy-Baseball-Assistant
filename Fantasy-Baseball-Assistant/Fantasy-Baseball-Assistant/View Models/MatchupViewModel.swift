//
//  MatchupViewModel.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 4/23/23.
//

import Foundation

class MatchupViewModel: ObservableObject {
    var matchups: [Matchup] = []
    @Published var currentMatchup: Matchup?
    @Published var playerStatus: String = "Not Starting"
    var selectedPlayer: Player
    var persistenceController: PersistenceController
    var dataRequester: DataRequester
    
    init(dataRequester: DataRequester, persistenceController: PersistenceController, selectedPlayer: Player) {
        self.dataRequester = dataRequester
        self.persistenceController = persistenceController
        self.selectedPlayer = selectedPlayer
        initializeData(persistenceController: persistenceController, dataRequester: dataRequester)
    }

    func getStartTime() -> String {
        guard currentMatchup != nil else {
            return ""
        }
        
        var meridiem: String
        let calendar = Calendar.current
        var hour = calendar.component(.hour, from: currentMatchup!.date)
        
        if (hour >= 12) {
            meridiem = "PM"
            if (hour > 12) {
                hour = hour % 12
            }
        } else {
            meridiem = "AM"
        }
        
        let minute = calendar.component(.minute, from: currentMatchup!.date)
        
        let minuteString = (minute < 10) ? "0\(minute)": "\(minute)"
        
        return "\(hour):\(minuteString) \(meridiem)"
    }
    
    func initializeData(persistenceController: PersistenceController, dataRequester: DataRequester) {
        matchups = persistenceController.loadMatchupsForDate(Date())
        
        if (matchups.isEmpty) {
            Task.init {
                print("Fetching matchup data")
                matchups = await dataRequester.getMatchupData(peristenceController: persistenceController)
                await MainActor.run {
                    persistenceController.saveData()
                    updateCurrentMatchup()
                }
            }
        } else {
            print("Matchup data found")
            updateCurrentMatchup()
        }
    }
    
    private func updateCurrentMatchup() {
        for matchup in matchups {
            if (matchup.away_team == selectedPlayer.team || matchup.home_team == selectedPlayer.team) {
                currentMatchup = matchup
                updatePlayerStatus()
            }
        }
    }
    
    private func updatePlayerStatus() {
        guard currentMatchup != nil else {
            return
        }
        
        if (selectedPlayer.team == currentMatchup!.home_team) {
            for startingPlayer in currentMatchup!.home_team_info.startingPlayers {
                if (selectedPlayer.api_id == startingPlayer) {
                    playerStatus = "Starting"
                    return
                }
            }
            playerStatus = "Not Starting"
            return
        } else if (selectedPlayer.team == currentMatchup!.away_team) {
            for startingPlayer in currentMatchup!.away_team_info.startingPlayers {
                if (selectedPlayer.api_id == startingPlayer) {
                    playerStatus = "Starting"
                    return
                }
            }
            playerStatus = "Not Starting"
            return
        }
    }
}
