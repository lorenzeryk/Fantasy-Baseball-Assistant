//
//  Roster.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 3/30/23.
//
import Foundation
import CoreData

/// Stores the players within the application and provides methods to create and delete players
struct Roster {
    /// Full Roster
    var players: [Player] = []

    /// Adds a player to the roster
    ///
    /// - Parameters:
    ///     - player: Player to be added to roster
    mutating func addPlayerToRoster(player: Player) {
        player.updateRawSecondaryPositions()
        players.append(player)
    }
    
    /// Updates players to new data and sets secondary positions for each player
    ///
    /// - Parameters:
    ///     - players: Array of players to initialize roster with
    mutating func initializeRoster(players: [Player]) {
        self.players = players
        for player in players {
            player.setSecondaryPositions()
        }
    }

    /// Returns player for corresponding ID
    ///
    /// - Parameters:
    ///     - playerID: ID of player looking to get
    /// - Returns: Player with corresponding ID or nil
    func getPlayerByID(playerID: Player.ID) -> Player? {
        for player in players {
            if (player.id == playerID) {
                return player
            }
        }
        return nil
    }
    
    /// Deletes player from rosterwith given ID
    ///
    /// - Parameters:
    ///     - playerID: ID of player to delete
    mutating func deletePlayerByID(playerID: Player.ID) {
        for (index, player) in players.enumerated() {
            if (player.id == playerID) {
                players.remove(at: index)
                return
            }
        }
    }
}
