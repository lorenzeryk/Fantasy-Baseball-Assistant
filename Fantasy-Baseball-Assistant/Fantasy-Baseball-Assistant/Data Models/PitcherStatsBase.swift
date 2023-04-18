//
//  PitcherStats.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 3/30/23.
//

import Foundation

class PitcherStatsBase: Identifiable {
    var win: Int16
    var loss: Int16
    var ip_2: Double
    var h: Int16
    var era: Double
    var ktotal: Int16
    var bb: Int16
    
    var hr: Int16
    var oba: Double
    var obp: Double
    var slg: Double
    var ops: Double
    var save: Int16
    var svo: Int16
    
    var whip: Double {
        Double(bb + h) / ip_2
    }
    
    var key: String
    var play: Int16

    
    init(win: Int, loss: Int, ip_2: Double, h: Int, era: Double, ktotal: Int, bb: Int, hr: Int, oba: Double, obp: Double, slg: Double, ops: Double, save: Int, svo: Int, key: String = "", play: Int) {
        self.win = Int16(win)
        self.loss = Int16(loss)
        self.save = Int16(save)
        self.svo = Int16(svo)
        self.play = Int16(play)
        self.ip_2 = ip_2
        self.h = Int16(h)
        self.hr = Int16(hr)
        self.bb = Int16(bb)
        self.oba = oba
        self.era = era
        self.ktotal = Int16(ktotal)
        self.obp = obp
        self.slg = slg
        self.ops = ops
        self.key = key
    }
    
    init() {
        self.win = 0
        self.loss = 0
        self.save = 0
        self.svo = 0
        self.play = 0
        self.ip_2 = 0
        self.h = 0
        self.hr = 0
        self.bb = 0
        self.oba = 0
        self.era = 0
        self.ktotal = 0
        self.obp = 0
        self.slg = 0
        self.ops = 0
        self.key = ""
    }
}
