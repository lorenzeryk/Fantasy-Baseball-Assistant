//
//  FielderStats.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 3/30/23.
//

import Foundation

class FielderStatsBase: Identifiable {
    var batting_average: Double
    var ab: Int
    var hits: Int
    var homeruns: Int
    var runs: Int
    var rbi: Int
    var strike_outs: Int
    var stolen_bases: Int
    var caught_stealing: Int
    
    var single: Int
    var double: Int
    var triple: Int
    var walks: Int
    var intentional_walks: Int
    var hit_by_pitch: Int
    var obp: Double
    var slg: Double
    var ops: Double
    
    var key: String?
    
    init(batting_average: Double, ab: Int, hits: Int, homeruns: Int, runs: Int, rbi: Int, stolen_bases: Int, obp: Double, slg: Double, ops: Double, single: Int, double: Int, triple: Int, walks: Int, intentional_walks: Int, hit_by_pitch: Int, caught_stealing: Int, strike_outs: Int, key: String? = nil) {
        self.batting_average = batting_average
        self.ab = ab
        self.hits = hits
        self.homeruns = homeruns
        self.runs = runs
        self.rbi = rbi
        self.stolen_bases = stolen_bases
        self.obp = obp
        self.slg = slg
        self.ops = ops
        self.single = single
        self.double = double
        self.triple = triple
        self.walks = walks
        self.intentional_walks = intentional_walks
        self.hit_by_pitch = hit_by_pitch
        self.caught_stealing = caught_stealing
        self.strike_outs = strike_outs
        self.key = key
    }
    
    init() {
        self.batting_average = 0.0
        self.ab = 0
        self.hits = 0
        self.homeruns = 0
        self.runs = 0
        self.rbi = 0
        self.stolen_bases = 0
        self.obp = 0.0
        self.slg = 0.0
        self.ops = 0.0
        self.single = 0
        self.double = 0
        self.triple = 0
        self.walks = 0
        self.intentional_walks = 0
        self.hit_by_pitch = 0
        self.caught_stealing = 0
        self.strike_outs = 0
        self.key = nil
    }
}
