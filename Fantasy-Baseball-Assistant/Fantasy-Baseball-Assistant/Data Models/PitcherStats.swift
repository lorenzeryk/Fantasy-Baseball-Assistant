//
//  PitcherStats.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 3/30/23.
//

import Foundation

class PitcherStats: BaseStats {
    var innings_pitched: Double = 0.0
    var WAR: Double = 0.0
    var win: Int = 0
    var loss: Int = 0
    var ERA: Double = 0.0
    var games_pitched: Int = 0
    var games_started: Int = 0
    var saves: Int = 0
    var strikeouts: Int = 0
    var whip: Double = 0.0
    
    init(innings_pitched: Double, WAR: Double, win: Int, loss: Int, ERA: Double, games_pitched: Int, games_started: Int, saves: Int, strikeouts: Int, whip: Double) {
        self.innings_pitched = innings_pitched
        self.WAR = WAR
        self.win = win
        self.loss = loss
        self.ERA = ERA
        self.games_pitched = games_pitched
        self.games_started = games_started
        self.saves = saves
        self.strikeouts = strikeouts
        self.whip = whip
    }
}
