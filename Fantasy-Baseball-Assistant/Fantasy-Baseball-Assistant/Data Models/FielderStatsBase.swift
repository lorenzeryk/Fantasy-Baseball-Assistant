//
//  FielderStats.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 3/30/23.
//

import Foundation

class FielderStatsBase: Identifiable {
    var batting_average: Double = 0.0
    var WAR: Double = 0.0
    var ab: Int = 0
    var hits: Int = 0
    var homeruns: Int = 0
    var runs: Int = 0
    var rbi: Int = 0
    var stolen_bases: Int = 0
    var obp: Double = 0.0
    var slg: Double = 0.0
    var ops: Double = 0.0
    var OPS_plus: Double = 0.0
    var key: String?

    init(batting_average: Double, WAR: Double, AB: Int, hits: Int, homeruns: Int, runs: Int, RBI: Int, stolen_bases: Int, OBP: Double, SLG: Double, OPS: Double, OPS_plus: Double, key: String?) {
        self.batting_average = batting_average
        self.WAR = WAR
        self.ab = AB
        self.hits = hits
        self.homeruns = homeruns
        self.runs = runs
        self.rbi = RBI
        self.stolen_bases = stolen_bases
        self.obp = OBP
        self.slg = SLG
        self.ops = OPS
        self.OPS_plus = OPS_plus
        self.key = key
    }
    
    init() {
        
    }
}
