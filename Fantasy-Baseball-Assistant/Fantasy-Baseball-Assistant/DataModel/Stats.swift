//
//  Stats.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 3/30/23.
//

import Foundation

struct Stats {
    var pitcher: Bool
    var season: BaseStats
    var month: BaseStats
    var week: BaseStats
    var home: BaseStats
    var away: BaseStats
    var byOpponent: [BaseStats]
}
