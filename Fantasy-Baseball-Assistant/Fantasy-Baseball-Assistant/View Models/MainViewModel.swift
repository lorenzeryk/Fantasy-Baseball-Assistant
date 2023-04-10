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
    @Published var selectedPlayer: Player? = nil
    @Published var selectedPlayerID: Player.ID? = nil {
        didSet {
            guard let newID = selectedPlayerID else {
                return
            }
            setSelectionFromTable(player: newID)
        }
    }
    
    func clearSelection() {
        showPlayerInfo = false
        self.selectedPlayer = nil
        self.selectedPlayerID = nil
    }
    
    func setSelectionFromTable(player: Player.ID) {
        selectedPlayer = roster.getPlayerByID(playerID: player)
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
    
    func saveData() {
        do {
            try PersistenceController.shared.container.viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func addPlayer(firstName: String, lastName: String, position: PlayerPosition, team: Team) {
        failedPlayerValidation = false
        let dataRequester = DataRequester()
        
        Task.init {
            guard await dataRequester.validatePlayer(first_name: firstName, last_name: lastName, team: team) != false else {
                //TODO: cite from https://developer.apple.com/forums/thread/718270
                DispatchQueue.main.async { [self] in
                    failedPlayerValidation = true
                }
                return
            }
            
            DispatchQueue.main.async { [self] in
                let tempPlayer = Player(first_name: firstName, last_name: lastName, team: team, primary_position: position, entity: NSEntityDescription.entity(forEntityName: "Player", in: PersistenceController.shared.container.viewContext)!, context: PersistenceController.shared.container.viewContext)
                roster.addPlayerToRoster(player: tempPlayer)
                cancelCreatingPlayer()
                saveData()
            }
        }
    }
    
    func deleteSelectedPlayer() {
        let fetchRequest: NSFetchRequest<Player> = Player.fetchRequest()
        
        guard let playerID = selectedPlayer?.id else {
            print("No selected player")
            return
        }
        
        guard selectedPlayer != nil else {
            print("No selected player. Failed to delete")
            return
        }
        
        fetchRequest.predicate = NSPredicate (
            format: "id == %@", playerID as CVarArg
        )

        do {
            let playerToDelete = try PersistenceController.shared.container.viewContext.fetch(fetchRequest) as [NSManagedObject]

            guard playerToDelete.count == 1 else {
                print("Did not find one player. Failed to delete")
                return
            }

            PersistenceController.shared.container.viewContext.delete(playerToDelete.first!)

        } catch {
            print("Failed to delete")
            return
        }
        roster.deletePlayerByID(playerID: playerID)
        clearSelection()
        saveData()
    }
}
