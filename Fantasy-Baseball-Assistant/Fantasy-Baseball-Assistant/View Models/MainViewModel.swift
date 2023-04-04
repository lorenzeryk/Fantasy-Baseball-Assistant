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
    }
    
    func addPlayer(firstName: String, lastName: String, position: PlayerPosition, team: Team) {
        roster.players.append(Player(first_name: firstName, last_name: lastName, team: team, primary_position: position))
    }
}
