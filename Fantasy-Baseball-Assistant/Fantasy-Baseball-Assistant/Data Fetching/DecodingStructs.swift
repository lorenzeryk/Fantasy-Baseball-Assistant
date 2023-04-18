/*
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

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
    var day_night: [PitchingStats]
    var month: [PitchingStats]
    var home_away: [PitchingStats]
    var hitter_hand: [PitchingStats]
    var opponent: [PitchingStats]
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
    var ab: Int //
    var runs: Int //
    var s: Int //single
    var d: Int //double
    var t: Int //triple
    var hr: Int //
    var rbi: Int //
    var bb: Int //
    var ibb: Int //
    var hbp: Int //
    var sb: Int //
    var cs: Int //
    var obp: Double //
    var slg: Double //
    var ops: Double //
    var h: Int //
    var ktotal: Int //
    var avg: String
    var value: String?
    var name: String?
}

struct PitchingStats: Codable {
    var win: Int?
    var loss: Int?
    var save: Int?
    var svo: Int?
    var play: Int?
    var ip_2: Double?
    var h: Int
    var hr: Int
    var bb: Int
    var oba: Double
    var era: Double?
    var ktotal: Int
    var obp: Double?
    var slg: Double?
    var ops: Double?
    var value: String?
    var name: String?
}

struct Stats {
    var hittingStats: FielderStats?
    var pitchingStats: PitcherStats?
}
