//
//  DecodingStructs.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 4/8/23.
//

import Foundation

struct RequestedPlayer: Codable {
    var first_name: String
    var preferred_name: String
    var last_name: String
    var primary_position: String
    var id: String
}

struct ReturnedTeamProfile: Codable {
    var players: [RequestedPlayer]
}
