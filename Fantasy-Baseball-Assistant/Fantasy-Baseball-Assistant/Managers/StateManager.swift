//
//  StateManager.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 4/12/23.
//

import Foundation

/// Manages the current state of the application and controls which views are displayed
class StateManager: ObservableObject {
    var dataRequester: DataRequester?
    var persistenceController: PersistenceController?
    
    /// Controls whether the player views are shown or if the roster view is shown
    @Published var showPlayerInfo = false
    /// Controls if the create player view is displayed
    @Published var displayCreatePlayerView = false
    /// Status of validation of player. Controls if create player view remains after submits and if error message is displayed to the user
    @Published var failedPlayerValidation = false
    /// Stores the currently selected player. On a change of the currently selected player, if not nil, then the stats for that player are updated
    @Published var selectedPlayer: Player? {
        didSet {
            if (selectedPlayer != nil && dataRequester != nil && persistenceController != nil) {
                selectedPlayer!.updateStats(dataRequester: dataRequester!, persistenceController: persistenceController!)
            }
        }
    }
    @Published var selectedPlayerID: Player.ID? = nil {
        didSet {
            if (selectedPlayerID == nil) {
                selectedPlayer = nil
            }
        }
    }
    
    /// Toggles showPlayerInfo
    ///
    /// If the selected player is nil then sets to false, else sets to to true
    ///
    /// - Parameters: The selected player or nil
    func updateShowPlayerInfo(selectedPlayer: Player?) {
        self.selectedPlayer = selectedPlayer
        if (selectedPlayer != nil) {
            showPlayerInfo = true
        } else {
            showPlayerInfo = false
        }
    }
    
    /// Toggles the create player view
    func setCreatePlayerStatus(_ status: Bool) {
        displayCreatePlayerView = status
    }
    
    /// Updates state when creating a player is cancelled
    ///
    /// Sets both failedPlayerValidation and displayCreatePlayerView to false
    func cancelCreatingPlayer() {
        displayCreatePlayerView = false
        failedPlayerValidation = false
    }
    
    /// Clears the selected player and sets showing the player views to false
    func clearSelection() {
        showPlayerInfo = false
        self.selectedPlayer = nil
        self.selectedPlayerID = nil
    }
}
