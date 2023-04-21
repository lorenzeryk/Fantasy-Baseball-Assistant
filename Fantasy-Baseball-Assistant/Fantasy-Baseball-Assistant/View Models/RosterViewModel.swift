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

    func addPlayer(firstName: String, lastName: String, position: PlayerPosition, team: Team, secondaryPositions: [PlayerPosition]?, dataRequester: DataRequester, persistenceController: PersistenceController) async -> (Bool, String?) {
        DispatchQueue.main.async { [self] in
            failedPlayerValidation = false
        }
        
        guard let player_id = await dataRequester.validatePlayer(first_name: firstName, last_name: lastName, team: team, primary_position: position.abbreviation) else {
            #warning ("TODO: cite from https://developer.apple.com/forums/thread/718270")
            DispatchQueue.main.async { [self] in
                failedPlayerValidation = true
            }
            return (false, "Failed to validate player")
        }

        guard let playerDescription = persistenceController.getDescription(entityName: "Player") else {
            print("Failed to get player description")
            return (false, "Internal Error")
        }
        
        DispatchQueue.main.async {
            let player = Player(first_name: firstName, last_name: lastName, api_id: player_id, team: team, primary_position: position, secondary_positions: secondaryPositions, entity: playerDescription, context: persistenceController.container.viewContext)
            self.roster.addPlayerToRoster(player: player)
            persistenceController.saveData()
            Task.init {
                sleep(2)
                player.updateStats(dataRequester: dataRequester, persistenceController: persistenceController)
            }
        }
        
        return (true, nil)
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
            Task.init {
                for player in roster.players {
                    sleep(2)
                    player.updateStats(dataRequester: dataRequester, persistenceController: persistenceController)
                }
            }
        }
    }
}
