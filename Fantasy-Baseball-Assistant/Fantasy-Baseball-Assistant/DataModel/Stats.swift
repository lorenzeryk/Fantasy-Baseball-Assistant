//
//  Stats.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 3/30/23.
//

import Foundation

struct Stats {
    var pitcher: Bool
    var season: BaseStats = BaseStats()
    var month: BaseStats = BaseStats()
    var week: BaseStats = BaseStats()
    var home: BaseStats = BaseStats()
    var away: BaseStats = BaseStats()
    var byOpponent: [BaseStats]
    
    init(pitcher: Bool, season: BaseStats, month: BaseStats, week: BaseStats, home: BaseStats, away: BaseStats, byOpponent: [BaseStats]) {
        self.pitcher = pitcher
        self.season = season
        self.month = month
        self.week = week
        self.home = home
        self.away = away
        self.byOpponent = byOpponent
    }
    
    init(season_pitching: PitcherStats) {
        self.pitcher = false
        self.season = BaseStats(pitching_stats: season_pitching)
        self.month = BaseStats()
        self.week = BaseStats()
        self.home = BaseStats()
        self.away = BaseStats()
        self.byOpponent = []
    }
    
    init(season_hitting: FielderStats) {
        self.pitcher = false
        self.season = BaseStats(hitting_stats: season_hitting)
        self.month = BaseStats()
        self.week = BaseStats()
        self.home = BaseStats()
        self.away = BaseStats()
        self.byOpponent = []
    }
}
