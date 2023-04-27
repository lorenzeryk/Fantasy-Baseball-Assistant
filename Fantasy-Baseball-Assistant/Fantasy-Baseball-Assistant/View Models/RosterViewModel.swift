//
//  MainViewModel.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 4/2/23.
//

import Foundation
import CoreData
import SwiftUI

/// View Model that contains all the players and handles add and deleting players
class RosterViewModel: NSObject, ObservableObject {    
    /// Roster object that contains all of the current players
    var roster: Roster = Roster() {
        didSet {
            updatePitchersHitters()
        }
    }
    
    @Published var hitters: [Player] = []
    @Published var pitchers: [Player] = []
    
    @Published var hittersSortOrder: [KeyPathComparator<Player>] = [
        .init(\.primary_position_raw, order: .forward)] {
            didSet {
                updatePitchersHitters()
            }
        }
    
    @Published var pitchersSortOrder: [KeyPathComparator<Player>] = [
        .init(\.primary_position_raw, order: .forward)] {
            didSet {
                updatePitchersHitters()
            }
        }
    
    /// Status of validation operation. If set to false then validation failed
    @Published var failedPlayerValidation = false
    
    /// Asynchronously adds a player to the roster
    ///
    /// Adds a player to the roster (if not already present in roster) and then fetches stats for that player
    ///
    /// - Parameters:
    ///   - firstName: The first name of the player
    ///   - lastName: The last name of the player
    ///   - position: The primary position of the player
    ///   - secondaryPositions: An optional array of the secondary positions of the player
    ///   - peristenceController: The instance of the Persistence Controller used throughout the application
    ///   - dataRequester: The instance of the Data Requester used throughout the application
    ///
    /// - Returns: Boolean value of the status of adding the player and an optional string for the error message displayed to the user if the player is unable to be added
    func addPlayer(firstName: String, lastName: String, position: PlayerPosition, team: Team, secondaryPositions: [PlayerPosition]?, dataRequester: DataRequester, persistenceController: PersistenceController) async -> (Bool, String?) {
        await MainActor.run() {
            failedPlayerValidation = false
        }
        
        guard let player_id = await dataRequester.validatePlayer(first_name: firstName, last_name: lastName, team: team, primary_position: position.abbreviation) else {
            await MainActor.run {
                failedPlayerValidation = true
            }
            
            return (false, "Failed to validate player")
        }
        
        guard checkForDuplicatePlayer(playerID: player_id) == false else {
            print("Duplicate player found")
            await MainActor.run {
                failedPlayerValidation = true
            }
            
            return (false, "Player is already addded")
        }

        guard let playerDescription = persistenceController.getDescription(entityName: "Player") else {
            print("Failed to get player description")
            return (false, "Internal Error")
        }
        
        let player = Player(first_name: firstName, last_name: lastName, api_id: player_id, team: team, primary_position: position, secondary_positions: secondaryPositions, entity: playerDescription, context: persistenceController.container.viewContext)

        await MainActor.run() {
            self.roster.addPlayerToRoster(player: player)
            persistenceController.saveData()
        }
        
        Task.init {
            sleep(2)
            player.updateStats(dataRequester: dataRequester, persistenceController: persistenceController)
        }
        
        return (true, nil)
    }
    
    /// Deletes player from Persistence and Roster
    ///
    ///  - Parameters:
    ///     - playerID: the UUID of the player to delete
    ///     - peristenceController: The instance of the Persistence Controller used throughout the application
    ///
    ///  - Returns: Boolean of result of delete operation
    func deletePlayer(_ playerID: Player.ID?, persistenceController: PersistenceController) -> Bool {
        guard playerID != nil else {
            print("No player selected to delete")
            return false
        }

        roster.deletePlayerByID(playerID: playerID!)
        
        guard persistenceController.deletePlayerByID(playerID!) == true else {
            print("Failed to delete player from core data")
            return false
        }
        return true
    }
    
    /// Initializes the data for the application
    ///
    ///  First the matchup data is loaded/fetched. Then all of the saved players are loaded and the stats are updated if necessary for each player
    ///
    ///   - Parameters:
    ///     - peristenceController: The instance of the Persistence Controller used throughout the application
    ///     - dataRequester: The instance of the Data Requester used throughout the application
    func initializeData(persistenceController: PersistenceController, dataRequester: DataRequester) {
        Task.init {
            print("Initializing matchup data")
            let matchupViewModel = MatchupViewModel(dataRequester: dataRequester, persistenceController: persistenceController, selectedPlayer: nil)
            matchupViewModel.initializeData(persistenceController: persistenceController, dataRequester: dataRequester)
        }
        
        if (roster.players.isEmpty) {
            let savedPlayers = persistenceController.loadPlayers()
            roster.initializeRoster(players: savedPlayers)
            Task.init {
                for player in roster.players {
                    sleep(2)
                    player.updateStats(dataRequester: dataRequester, persistenceController: persistenceController)
                }
            }
        }
    }
    
    /// Check if a player is already in the roster
    ///
    ///  - Parameters:
    ///     - playerID: The id from the sportsradar api for the player
    ///
    ///  - Returns: True if that player is already present in the roster
    private func checkForDuplicatePlayer(playerID: String) -> Bool {
        for player in roster.players {
            if (player.api_id == playerID) {
                return true
            }
        }
        return false
    }
    
    /// Updates arrays of position players and pitchers
    private func updatePitchersHitters() {
        hitters = []
        pitchers = []

        for player in roster.players {
            if player.isPitcher() {
                pitchers.append(player)
            } else {
                hitters.append(player)
            }
        }
        
        hitters = hitters.sorted(using: hittersSortOrder)
        pitchers = pitchers.sorted(using: pitchersSortOrder)
    }
}
