//
//  MatchupViewModel.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 4/23/23.
//

import Foundation

/// View Model that handles initiating request for new matchup data and extracts matchup for currently selected player
class MatchupViewModel: ObservableObject {
    var matchups: [Matchup] = []
    @Published var currentMatchup: Matchup?
    
    /// String representation of if currently selected player is starting for the current matchup
    @Published var playerStatus: String = "Not Starting"
    
    var selectedPlayer: Player?
    
    /// The frequency at which new data is requested from the server in seconds. Set to once every 24 hours currently
    var dataRefreshTime: Double = 60 * 60 * 24
    
    init(dataRequester: DataRequester, persistenceController: PersistenceController, selectedPlayer: Player?) {
        self.selectedPlayer = selectedPlayer
        initializeData(persistenceController: persistenceController, dataRequester: dataRequester)
    }
    
    /// Method to extract start time of game for current matchup
    ///
    ///  - Returns: String for start time in format of "Hour: Minute AM/PM Timezone"
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
    
    /// Load/Fetch data for all matchups across league
    ///
    /// If the attempt to load data from the persistence storage returns nothing for the current date or if the data is older than the dataRefreshTime then new data is requested from the server. After
    /// the data is either loaded or fetched then the current matchup is set to the selected player and the player's status for today is also updated
    ///
    /// - Parameters:
    ///   - peristenceController: The instance of the Persistence Controller used throughout the application
    ///   - dataRequester: The instance of the Data Requester used throughout the application
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
