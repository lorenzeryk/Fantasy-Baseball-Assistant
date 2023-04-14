//
//  FielderStats.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 4/14/23.
//

import Foundation

class FielderStats {
    var season: FielderStatsBase = FielderStatsBase()
    var month: [FielderStatsBase] = []
    var day_night: [FielderStatsBase] = []
    var byOpponent: [FielderStatsBase] = []
    var home_away: [FielderStatsBase] = []
}
