//
//  Roster.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 3/30/23.
//
import Foundation
import CoreData

struct Roster {
    var players: [Player] = []
    var pitchers: [Player] = []
    var hitters: [Player] = []

    mutating func addPlayerToRoster(player: Player) {
        player.updateRawSecondaryPositions()
        players.append(player)
        updatePitchersHitters()
    }
    
    mutating func updatePitchersHitters() {
        hitters = []
        pitchers = []

        for player in players {
            if player.isPitcher() {
                pitchers.append(player)
            } else {
                hitters.append(player)
            }
        }
    }
    
    mutating func initializeRoster(players: [Player]) {
        self.players = players
        for player in players {
            player.setSecondaryPositions()
        }
        updatePitchersHitters()
    }

    func getPlayerByID(playerID: Player.ID) -> Player? {
        for player in players {
            if (player.id == playerID) {
                return player
            }
        }
        return nil
    }
    
    mutating func deletePlayerByID(playerID: Player.ID) {
        for (index, player) in players.enumerated() {
            if (player.id == playerID) {
                players.remove(at: index)
                updatePitchersHitters()
                return
            }
        }
    }
}
