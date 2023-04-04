//
//  Player.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 3/30/23.
//

import Foundation

struct Player: Identifiable, Hashable {
    static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id = UUID()
    var first_name: String
    var last_name: String
    var positions: [PlayerPosition]
    var primary_position: PlayerPosition
    var stats: Stats? = nil
    var team: Team
    
    init(first_name: String, last_name: String, team: Team) {
        self.first_name = first_name
        self.last_name = last_name
        self.team = team
        self.primary_position = PlayerPosition.None
        self.positions = []
    }
    
    init(first_name: String, last_name: String, team: Team, primary_position: PlayerPosition) {
        self.first_name = first_name
        self.last_name = last_name
        self.team = team
        self.primary_position = primary_position
        self.positions = []
    }
    
    init(first_name: String, last_name: String, team: Team, primary_position: PlayerPosition, positions: [PlayerPosition]) {
        self.first_name = first_name
        self.last_name = last_name
        self.team = team
        self.primary_position = primary_position
        self.positions = positions
    }
    
    func isPitcher() -> Bool {
        if (primary_position == PlayerPosition.SP || primary_position == PlayerPosition.RP) {
            return true
        } else {
            return false
        }
    }
}
