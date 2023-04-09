//
//  MainViewModel.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 4/2/23.
//

import Foundation

class MainViewModel: ObservableObject {
    @Published var roster: Roster = Roster()
    @Published var selectedPlayer: Player? = nil {
        didSet {
            if (selectedPlayer != nil) {
                showPlayerInfo = true
            } else {
                showPlayerInfo = false
            }
        }
    }
    @Published var showPlayerInfo = false
    @Published var displayCreatePlayerView = false
    @Published var failedPlayerValidation = false
    
    func clearSelection() {
        self.selectedPlayer = nil
    }
    
    func setSelectionFromTable(player: Set<Player.ID>) {
        selectedPlayer = roster.getPlayerByID(playerID: player)
    }
    
    func setCreatePlayerStatus(_ status: Bool) {
        displayCreatePlayerView = status
    }
    
    func cancelCreatingPlayer() {
        displayCreatePlayerView = false
        failedPlayerValidation = false
    }
    
    func addPlayer(firstName: String, lastName: String, position: PlayerPosition, team: Team) {
        failedPlayerValidation = false
        let dataRequester = DataRequester()
        
        Task.init {
            guard await dataRequester.validatePlayer(first_name: firstName, last_name: lastName, team: team) != false else {
                DispatchQueue.main.async { [self] in
                    failedPlayerValidation = true
                }
                return
            }
            
            DispatchQueue.main.async { [self] in
                roster.players.append(Player(first_name: firstName, last_name: lastName, team: team, primary_position: position))
                cancelCreatingPlayer()
            }
        }
    }
}
