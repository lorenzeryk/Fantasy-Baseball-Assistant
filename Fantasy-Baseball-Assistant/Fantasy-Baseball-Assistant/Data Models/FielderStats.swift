//
//  FielderStats.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 4/14/23.
//

import Foundation

class FielderStats {
    var season: FielderStatsBase = FielderStatsBase()
    var month: FielderStatsBase = FielderStatsBase()
    var week: FielderStatsBase = FielderStatsBase()
    var home: FielderStatsBase = FielderStatsBase()
    var away: FielderStatsBase = FielderStatsBase()
    var byOpponent: [FielderStatsBase] = []
}
