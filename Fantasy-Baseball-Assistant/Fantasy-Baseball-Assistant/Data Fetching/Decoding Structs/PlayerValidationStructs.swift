//
//  PlayerValidationStructs.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 4/22/23.
//

import Foundation

/// Decoding: Player data extracted when validating a player
struct RequestedPlayer: Codable {
    var first_name: String
    var preferred_name: String
    var last_name: String
    var primary_position: String
    var id: String
}

/// Decoding: Contains array of all players recieved from server
struct ReturnedTeamProfile: Codable {
    var players: [RequestedPlayer]
}
