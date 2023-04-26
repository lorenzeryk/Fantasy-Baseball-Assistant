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
    var selectedPlayer: Player?
    var dataRefreshTime: Double = 60 * 60 * 24
    
    init(dataRequester: DataRequester, persistenceController: PersistenceController, selectedPlayer: Player?) {
        self.selectedPlayer = selectedPlayer
        initializeData(persistenceController: persistenceController, dataRequester: dataRequester)
    }

    func getStartTime() -> String {
        guard currentMatchup != nil else {
            return ""
        }
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "h:m a"
        
        let startTime =  dateformatter.string(from: currentMatchup!.date)
        let timezone = TimeZone.current.abbreviation() ?? ""
        
        return "\(startTime) \(timezone)"
    }
    
    func initializeData(persistenceController: PersistenceController, dataRequester: DataRequester) {
        matchups = persistenceController.loadMatchupsForDate(Date())
        
        if (matchups.isEmpty || matchups.first!.fetch_date.distance(to: Date()) > dataRefreshTime) {
            matchups = []
            persistenceController.deleteMatchupsForDate(Date())
            requestMatchupData(dataRequester: dataRequester, persistenceController: persistenceController)
        }
        
        updateCurrentMatchup()
    }
    
    private func requestMatchupData(dataRequester: DataRequester, persistenceController: PersistenceController) {
        Task.init {
            print("Fetching matchup data")
            matchups = await dataRequester.getMatchupData(peristenceController: persistenceController)
            await MainActor.run {
                persistenceController.saveData()
            }
        }
    }
    
    private func updateCurrentMatchup() {
        guard selectedPlayer != nil else {
            return
        }
        
        for matchup in matchups {
            if (matchup.away_team == selectedPlayer!.team || matchup.home_team == selectedPlayer!.team) {
                currentMatchup = matchup
                updatePlayerStatus()
            }
        }
    }
    
    private func updatePlayerStatus() {
        guard currentMatchup != nil else {
            return
        }
        
        guard selectedPlayer != nil else {
            return
        }
        
        if (selectedPlayer!.team == currentMatchup!.home_team) {
            for startingPlayer in currentMatchup!.home_team_info.startingPlayers {
                if (selectedPlayer!.api_id == startingPlayer) {
                    playerStatus = "Starting"
                    return
                }
            }
            playerStatus = "Not Starting"
            return
        } else if (selectedPlayer!.team == currentMatchup!.away_team) {
            for startingPlayer in currentMatchup!.away_team_info.startingPlayers {
                if (selectedPlayer!.api_id == startingPlayer) {
                    playerStatus = "Starting"
                    return
                }
            }
            playerStatus = "Not Starting"
            return
        }
    }
}
