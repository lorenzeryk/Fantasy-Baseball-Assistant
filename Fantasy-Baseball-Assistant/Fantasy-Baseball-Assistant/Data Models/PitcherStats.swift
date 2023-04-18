//
//  PitcherStats.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 4/14/23.
//

import Foundation

class PitcherStats {
    var season: PitcherStatsBase = PitcherStatsBase()
    var month: [PitcherStatsBase] = []
    var day_night: [PitcherStatsBase] = []
    var home_away: [PitcherStatsBase] = []
    var byOpponent: [PitcherStatsBase] = []
}
