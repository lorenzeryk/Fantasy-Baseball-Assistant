//
//  MainViewModel.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 4/2/23.
//

import Foundation
import CoreData
import SwiftUI

class MainViewModel: NSObject, ObservableObject {
    @Published var roster: Roster = Roster()
    @Published var showPlayerInfo = false
    @Published var displayCreatePlayerView = false
    @Published var failedPlayerValidation = false
    @Published var selectedPlayer: Player? = nil {
        didSet {
            updateShowPlayerInfo()
        }
    }
    @Published var selectedPlayerID: Player.ID? = nil {
        didSet {
            guard let newID = selectedPlayerID else {
                return
            }
            setSelectionFromTable(player: newID)
        }
    }
    var persistenceController: PersistenceController = PersistenceController()
    var dataRequester: DataRequester = DataRequester()
    
    override init() {
        super.init()
        initializeData()
    }
    
    func clearSelection() {
        showPlayerInfo = false
        self.selectedPlayer = nil
        self.selectedPlayerID = nil
    }
    
    func setSelectionFromTable(player: Player.ID) {
        selectedPlayer = roster.getPlayerByID(playerID: player)
        showPlayerInfo = false
    }
    
    func updateShowPlayerInfo() {
        if (selectedPlayer != nil) {
            showPlayerInfo = true
        } else {
            showPlayerInfo = false
        }
    }
    
    func setCreatePlayerStatus(_ status: Bool) {
        displayCreatePlayerView = status
    }
    
    func cancelCreatingPlayer() {
        displayCreatePlayerView = false
        failedPlayerValidation = false
    }
    
    func addPlayer(firstName: String, lastName: String, position: PlayerPosition, team: Team, secondaryPositions: [PlayerPosition]?) {
        failedPlayerValidation = false
        
        Task.init {
            guard let player_id = await dataRequester.validatePlayer(first_name: firstName, last_name: lastName, team: team) else {
                //TODO: cite from https://developer.apple.com/forums/thread/718270
                DispatchQueue.main.async { [self] in
                    failedPlayerValidation = true
                }
                return
            }

            DispatchQueue.main.async { [self] in
                guard let playerDescription = persistenceController.getDescription(entityName: "Player") else {
                    print("Failed to get player description")
                    return
                }
                
                roster.addPlayerToRoster(player: Player(first_name: firstName, last_name: lastName, api_id: player_id, team: team, primary_position: position, secondary_positions: secondaryPositions, entity: playerDescription, context: persistenceController.container.viewContext))
                cancelCreatingPlayer()
                persistenceController.saveData()
            }
        }
    }
    
    func deleteSelectedPlayer() {
        guard let playerID = selectedPlayer?.id else {
            print("No selected player")
            return
        }
        
        guard selectedPlayer != nil else {
            print("No selected player. Failed to delete")
            return
        }
        
        guard persistenceController.deletePlayerByID(playerID) == true else {
            print("Failed to delete player from core data")
            return
        }
        roster.deletePlayerByID(playerID: playerID)
        clearSelection()
    }
    
    func initializeData() {
        let savedPlayers = persistenceController.loadPlayers()
        roster.initializeRoster(players: savedPlayers)
    }
}
