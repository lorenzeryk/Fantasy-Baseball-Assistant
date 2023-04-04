//
//  FielderStats.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 3/30/23.
//

import Foundation

class FielderStats: BaseStats {
    var batting_average: Double = 0.0
    var WAR: Double = 0.0
    var AB: Int = 0
    var hits: Int = 0
    var homeruns: Int = 0
    var runs: Int = 0
    var RBI: Int = 0
    var stolen_bases: Int = 0
    var OBP: Double = 0.0
    var SLG: Double = 0.0
    var OPS: Double = 0.0
    var OPS_plus: Double = 0.0

    init(batting_average: Double, WAR: Double, AB: Int, hits: Int, homeruns: Int, runs: Int, RBI: Int, stolen_bases: Int, OBP: Double, SLG: Double, OPS: Double, OPS_plus: Double) {
        self.batting_average = batting_average
        self.WAR = WAR
        self.AB = AB
        self.hits = hits
        self.homeruns = homeruns
        self.runs = runs
        self.RBI = RBI
        self.stolen_bases = stolen_bases
        self.OBP = OBP
        self.SLG = SLG
        self.OPS = OPS
        self.OPS_plus = OPS_plus
    }
}
