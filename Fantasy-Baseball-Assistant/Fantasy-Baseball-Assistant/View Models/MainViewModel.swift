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
    
    func clearSelection() {
        self.selectedPlayer = nil
    }
    
    func setSelectionFromTable(player: Set<Player.ID>) {
        selectedPlayer = roster.getPlayerByID(playerID: player)
    }
}
