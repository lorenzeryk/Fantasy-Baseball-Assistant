//
//  Roster.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 3/30/23.
//
import Foundation

struct Roster {
    var players: [Player] {
        didSet {
            updatePitchersHitters()
        }
    }
    var pitchers: [Player]
    var hitters: [Player]
    var total_players_count: Int
    var players_count_by_position: [Int]
    
    init() {
        players = []
        pitchers = []
        hitters = []
        total_players_count = 0
        players_count_by_position = []
    }
    
    init(testData: Bool) {
        self.init()
        createTestDataPlayers()
    }
    
    mutating func updatePitchersHitters() {
        hitters = []
        pitchers = []
        
        for player in players {
            if player.isPitcher() {
                pitchers.append(player)
            } else {
                hitters.append(player)
            }
        }
    }
    
    func getPlayerByID(playerID: Set<Player.ID>) -> Player? {
        for player in players {
            if (player.id == playerID.first) {
                return player
            }
        }
        
        return nil
    }
    
    mutating func createTestDataPlayers() {
        self.players = [Player(first_name: "Clayton", last_name: "Kershaw", team: Team.Dodgers, primary_position: PlayerPosition.SP), Player(first_name: "Byron", last_name: "Buxton", team: Team.Twins, primary_position: PlayerPosition.Center), Player(first_name: "Francisco", last_name: "Lindor", team: Team.Mets, primary_position: PlayerPosition.Short), Player(first_name: "Aroldis", last_name: "Chapman", team: Team.Royals, primary_position: PlayerPosition.RP)]
        
        players[0].stats = Stats(season_pitching: PitcherStats(innings_pitched: 20.0, WAR: 12.1, win: 5, loss: 3, ERA: 2.38, games_pitched: 15, games_started: 15, saves: 0, strikeouts: 45, whip: 1.38))
        
        players[1].stats = Stats(season_hitting: FielderStats(batting_average: 0.320, WAR: 12.8, AB: 220, hits: 56, homeruns: 14, runs: 75, RBI: 53, stolen_bases: 14, OBP: 1.250, SLG: 1.350, OPS: 0.980, OPS_plus: 1.950))
        
        players[2].stats = (Stats(season_hitting: FielderStats(batting_average: 0.220, WAR: 4.5, AB: 245, hits: 65, homeruns: 22, runs: 68, RBI: 73, stolen_bases: 12, OBP: 1.250, SLG: 1.2, OPS: 1.450, OPS_plus: 1.980)))
        
        players[3].stats = Stats(season_pitching: PitcherStats(innings_pitched: 14.0, WAR: 8.2, win: 0, loss: 2, ERA: 2.45, games_pitched: 14, games_started: 0, saves: 12, strikeouts: 65, whip: 1.1))
    }
}
