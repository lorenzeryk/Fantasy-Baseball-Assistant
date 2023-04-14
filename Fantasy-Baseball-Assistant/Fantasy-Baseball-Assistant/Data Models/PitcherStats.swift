//
//  PitcherStats.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 4/14/23.
//

import Foundation

class PitcherStats {
    var season: PitcherStatsBase = PitcherStatsBase()
    var month: PitcherStatsBase = PitcherStatsBase()
    var week: PitcherStatsBase = PitcherStatsBase()
    var home: PitcherStatsBase = PitcherStatsBase()
    var away: PitcherStatsBase = PitcherStatsBase()
    var byOpponent: [PitcherStatsBase] = []
}
