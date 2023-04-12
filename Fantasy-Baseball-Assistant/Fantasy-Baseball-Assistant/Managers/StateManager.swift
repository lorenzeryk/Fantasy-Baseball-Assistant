//
//  StateManager.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 4/12/23.
//

import Foundation

class StateManager: ObservableObject {
    @Published var showPlayerInfo = false
    @Published var displayCreatePlayerView = false
    @Published var failedPlayerValidation = false
    @Published var selectedPlayer: Player?
    @Published var selectedPlayerID: Player.ID? = nil {
        didSet {
            if (selectedPlayerID == nil) {
                selectedPlayer = nil
            }
        }
    }
    
    func updateShowPlayerInfo(selectedPlayer: Player?) {
        self.selectedPlayer = selectedPlayer
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
    
    func clearSelection() {
        showPlayerInfo = false
        self.selectedPlayer = nil
        self.selectedPlayerID = nil
    }
}
