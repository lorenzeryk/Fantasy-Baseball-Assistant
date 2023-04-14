//
//  MainViewModel.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 4/2/23.
//

import Foundation
import CoreData
import SwiftUI

class RosterViewModel: NSObject, ObservableObject {
    @Published var roster: Roster = Roster()
    @Published var failedPlayerValidation = false
    var persistenceController: PersistenceController = PersistenceController()
    var dataRequester: DataRequester = DataRequester()
    
    override init() {
        super.init()
        initializeData()
    }
    
    func addPlayer(firstName: String, lastName: String, position: PlayerPosition, team: Team, secondaryPositions: [PlayerPosition]?) async -> Bool {
        DispatchQueue.main.async { [self] in
            failedPlayerValidation = false
        }
        
        guard let player_id = await dataRequester.validatePlayer(first_name: firstName, last_name: lastName, team: team) else {
            //TODO: cite from https://developer.apple.com/forums/thread/718270
            DispatchQueue.main.async { [self] in
                failedPlayerValidation = true
            }
            return false
        }

        guard let playerDescription = persistenceController.getDescription(entityName: "Player") else {
            print("Failed to get player description")
            return false
        }
        
        DispatchQueue.main.async { [self] in
            roster.addPlayerToRoster(player: Player(first_name: firstName, last_name: lastName, api_id: player_id, team: team, primary_position: position, secondary_positions: secondaryPositions, entity: playerDescription, context: persistenceController.container.viewContext))
            persistenceController.saveData()
        }
        return true
    }

    func updateStats(player: Player) async {
        guard let playerStats = await dataRequester.getPlayerStats(player) else {
            print("Failed to retrieve stats for \(player.first_name) \(player.last_name)")
            return
        }
        
        player.hittingStats = playerStats.hittingStats
        player.pitchingStats = playerStats.pitchingStats
        
    }
    
    func deleteSelectedPlayer(_ playerID: Player.ID?) {
        guard playerID != nil else {
            print("No player selected to delete")
            return
        }

        roster.deletePlayerByID(playerID: playerID!)
        
        guard persistenceController.deletePlayerByID(playerID!) == true else {
            print("Failed to delete player from core data")
            return
        }
        
    }
    
    func initializeData() {
        let savedPlayers = persistenceController.loadPlayers()
        roster.initializeRoster(players: savedPlayers)
        
        Task.init {
            for player in roster.players {
                sleep(2)
                Task.init {
                    await updateStats(player: player)
                }
            }
        }
    }
}
