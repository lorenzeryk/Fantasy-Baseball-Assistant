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

    func addPlayer(firstName: String, lastName: String, position: PlayerPosition, team: Team, secondaryPositions: [PlayerPosition]?, dataRequester: DataRequester, persistenceController: PersistenceController) async -> Bool {
        DispatchQueue.main.async { [self] in
            failedPlayerValidation = false
        }
        
        guard let player_id = await dataRequester.validatePlayer(first_name: firstName, last_name: lastName, team: team) else {
            #warning ("TODO: cite from https://developer.apple.com/forums/thread/718270")
            DispatchQueue.main.async { [self] in
                failedPlayerValidation = true
            }
            return false
        }

        guard let playerDescription = persistenceController.getDescription(entityName: "Player") else {
            print("Failed to get player description")
            return false
        }
        
        let player = Player(first_name: firstName, last_name: lastName, api_id: player_id, team: team, primary_position: position, secondary_positions: secondaryPositions, entity: playerDescription, context: persistenceController.container.viewContext)
        roster.addPlayerToRoster(player: player)
        updateStats(player: player, dataRequester: dataRequester, persistenceController: persistenceController)
        persistenceController.saveData()
        return true
    }

    func updateStats(player: Player, dataRequester: DataRequester, persistenceController: PersistenceController) {
        Task.init {
            if ((player.hittingStats == nil && player.pitchingStats == nil) || player.last_stat_update.distance(to: Date()) > (60 * 60 * 24)) {
                sleep(2)
                guard let playerStats = await dataRequester.getPlayerStats(player, persistenceController: persistenceController) else {
                    print("Failed to retrieve stats for \(player.first_name) \(player.last_name)")
                    return
                }
                
                DispatchQueue.main.async {
                    player.hittingStats = playerStats.hittingStats
                    player.pitchingStats = playerStats.pitchingStats
                    
                    if (player.hittingStats != nil || player.pitchingStats != nil) {
                        player.last_stat_update = Date()
                    }
                    persistenceController.saveData()
                }
            } else {
                print("Stats not updated for \(player.first_name) \(player.last_name)")
            }
        }
    }
    
    func deleteSelectedPlayer(_ playerID: Player.ID?, persistenceController: PersistenceController) {
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
    
    func initializeData(persistenceController: PersistenceController, dataRequester: DataRequester) {
        if (roster.players.isEmpty) {
            let savedPlayers = persistenceController.loadPlayers()
            roster.initializeRoster(players: savedPlayers)
            for player in roster.players {
                updateStats(player: player, dataRequester: dataRequester, persistenceController: persistenceController)
            }
        }
    }
}
