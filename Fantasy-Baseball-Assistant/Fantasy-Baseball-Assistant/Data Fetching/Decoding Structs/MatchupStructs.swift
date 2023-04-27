//
//  MatchupStructs.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 4/22/23.
//

import Foundation

/// Decoding: Returned matchup data from request to get matchups
struct ReturnedMatchup: Codable {
    var league: League?
}

/// Decoding: Contains date returend from server and array of all game for that date
struct League: Codable {
    var date: String?
    var games: [Games]?
}

/// Decoding: Contains all information for a game
struct Games: Codable {
    var game: Game?
}

/// Decoding: Contains all information for a game
struct Game: Codable {
    /// Scheduled start time
    var scheduled: String?
    var home_team: String?
    var away_team: String?
    var weather: Weather?
    var home: TeamData?
    var away: TeamData?
}

/// Decoding: Current and forecased weather data for a matchup
struct Weather: Codable {
    var forecast: WeatherData?
    var current_conditions: WeatherData?
}

/// Decoding: Weather data for matchup returned from server
struct WeatherData: Codable {
    var temp_f: Int?
    var condition: String?
    var humidity: Int?
    var dew_point_f: Int?
    var cloud_cover: Int?
}

/// Decoding: All data for a team for a matchup
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

/// Decoding: Used to store player id from lineups and scheduled pitchers
struct PlayerID: Codable {
    var id: String?
}
