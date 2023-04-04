//
//  BaseStats.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 3/30/23.
//

import Foundation

class BaseStats {
    var pitching_stats: PitcherStats? = nil
    var hitting_stats: FielderStats? = nil
    
    init(pitching_stats: PitcherStats? = nil, hitting_stats: FielderStats? = nil) {
        self.pitching_stats = pitching_stats
        self.hitting_stats = hitting_stats
    }
}
