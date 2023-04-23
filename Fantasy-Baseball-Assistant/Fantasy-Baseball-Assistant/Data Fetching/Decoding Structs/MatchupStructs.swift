//
//  MatchupStructs.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 4/22/23.
//

import Foundation

struct ReturnedMatchup: Codable {
    var league: League?
}

struct League: Codable {
    var date: String?
    var games: [Games]?
}

struct Games: Codable {
    var game: Game?
}

struct Game: Codable {
    var scheduled: String?
    var home_team: String?
    var away_team: String?
    var weather: Weather?
    var home: TeamData?
    var away: TeamData?
}

struct Weather: Codable {
    var forecast: WeatherData?
    var current_conditions: WeatherData?
}

struct WeatherData: Codable {
    var temp_f: Int?
    var condition: String?
    var humidity: Int?
    var dew_point_f: Int?
    var cloud_cover: Int?
}

struct TeamData: Codable {
    var name: String?
    var id: String?
    var win: Int?
    var loss: Int?
    var probable_pitcher: PlayerID?
    var starting_pitcher: PlayerID?
    var current_pitcher: PlayerID?
    var lineup: [PlayerID]?
}

struct PlayerID: Codable {
    var id: String?
}
