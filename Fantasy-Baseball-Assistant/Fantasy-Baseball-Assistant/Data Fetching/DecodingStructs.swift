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

struct ReturnedStats: Codable {
    var players: [PlayerStats]
}

struct PlayerStats: Codable {
    var first_name: String?
    var last_name: String?
    var id: String?
    var splits: Splits
}

struct Splits: Codable {
    var hitting: Hitting?
    var pitching: Pitching?
}

struct Hitting: Codable {
    var overall: [OverallHitting]
}

struct Pitching: Codable {
    var overall: [OverallPitching]
}

struct OverallPitching: Codable {
    var total: [PitchingStats]
//    var day_night: [PitchingStats]
//    var month: [PitchingStats]
//    var home_away: [PitchingStats]
//    var hitter_hand: [PitchingStats]
//    var opponent: [PitchingStats]
}

struct OverallHitting: Codable {
    var total: [HittingStats]
    var day_night: [HittingStats]
    var month: [HittingStats]
    var home_away: [HittingStats]
    var pitcher_hand: [HittingStats]
    var opponent: [HittingStats]
}

struct HittingStats: Codable {
    var ab: Int
    var runs: Int
    var s: Int //single
    var d: Int //double
    var t: Int //triple
    var hr: Int
    var rbi: Int
    var bb: Int
    var ibb: Int
    var hbp: Int
    var sb: Int
    var cs: Int
    var obp: Double
    var slg: Double
    var ops: Double
    var h: Int
    var ktotal: Int
    var avg: String
    var value: String?
    var abbr: String?
}

struct PitchingStats: Codable {
    var win: Int
    var loss: Int
    var save: Int
    var svo: Int
    var start: Int
    var play: Int
    var complete: Int
    var team_win: Int
    var team_loss: Int
    var ip_2: Double
    var h: Int
    var runs: Int
    var er: Int
    var hr: Int
    var bb: Int
    var ibb: Int
    var oba: Double
    var era: Double
    var ktotal: Int
    var s: Int
    var d: Int
    var t: Int
    var rbi: Int
    var hbp: Int
    var sb: Int
    var cs: Int
    var obp: Double
    var slg: Double
    var ops: Double
    var bf: Int
    var value: String?
    var abbr: String?
}
