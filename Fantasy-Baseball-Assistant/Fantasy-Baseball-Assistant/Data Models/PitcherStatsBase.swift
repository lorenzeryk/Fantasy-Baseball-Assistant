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
    
    var key: String
    
    var bf: Int16
    var team_win: Int16
    var team_loss: Int16
    var complete: Int16
    var s: Int16
    var d: Int16
    var t: Int16
    var er: Int16
    var runs: Int16
    var start: Int16
    var play: Int16
    var rbi: Int16
    var ibb: Int16
    var hbp: Int16
    var sb: Int16
    var cs: Int16
    
    init(win: Int, loss: Int, save: Int, svo: Int, start: Int, play: Int, complete: Int, team_win: Int, team_loss: Int, ip_2: Double, h: Int, runs: Int, er: Int, hr: Int, bb: Int, ibb: Int, oba: Double, era: Double, ktotal: Int, s: Int, d: Int, t: Int, rbi: Int, hbp: Int, sb: Int, cs: Int, obp: Double, slg: Double, ops: Double, bf: Int, key: String = "") {
        self.win = Int16(win)
        self.loss = Int16(loss)
        self.save = Int16(save)
        self.svo = Int16(svo)
        self.start = Int16(start)
        self.play = Int16(play)
        self.complete = Int16(complete)
        self.team_win = Int16(team_win)
        self.team_loss = Int16(team_loss)
        self.ip_2 = ip_2
        self.h = Int16(h)
        self.runs = Int16(runs)
        self.er = Int16(er)
        self.hr = Int16(hr)
        self.bb = Int16(bb)
        self.ibb = Int16(ibb)
        self.oba = oba
        self.era = era
        self.ktotal = Int16(ktotal)
        self.s = Int16(s)
        self.d = Int16(d)
        self.t = Int16(t)
        self.rbi = Int16(rbi)
        self.hbp = Int16(hbp)
        self.sb = Int16(sb)
        self.cs = Int16(cs)
        self.obp = obp
        self.slg = slg
        self.ops = ops
        self.bf = Int16(bf)
        self.key = key
    }
    
    init() {
        self.win = 0
        self.loss = 0
        self.save = 0
        self.svo = 0
        self.start = 0
        self.play = 0
        self.complete = 0
        self.team_win = 0
        self.team_loss = 0
        self.ip_2 = 0
        self.h = 0
        self.runs = 0
        self.er = 0
        self.hr = 0
        self.bb = 0
        self.ibb = 0
        self.oba = 0
        self.era = 0
        self.ktotal = 0
        self.s = 0
        self.d = 0
        self.t = 0
        self.rbi = 0
        self.hbp = 0
        self.sb = 0
        self.cs = 0
        self.obp = 0
        self.slg = 0
        self.ops = 0
        self.bf = 0
        self.key = ""
    }
}
