//
//  Team.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 3/30/23.
//

import Foundation

enum Team: Int {
    case Diamondbacks = 0
    case Braves = 1
    case Orioles = 2
    case RedSox = 3
    case WhiteSox = 4
    case Cubs = 5
    case Reds = 6
    case Guardings = 7
    case Rockies = 8
    case Tigers = 9
    case Astros = 10
    case Royals = 11
    case Angels = 12
    case Dodgers = 13
    case Marlins = 14
    case Brewers = 15
    case Twins = 16
    case Yankees = 17
    case Mets = 18
    case Athletics = 19
    case Phillies = 20
    case Pirates = 21
    case Padres = 22
    case Giants = 23
    case Mariners = 24
    case Cardinals = 25
    case Rays = 26
    case Rangers = 27
    case BlueJays = 28
    case Nationals = 29
    
    var abbreviation: String {
        switch self {
        case .Diamondbacks: return "ARI"
        case .Braves: return "ATL"
        case .Orioles: return "BAL"
        case .RedSox: return "BOS"
        case .WhiteSox: return "CHW"
        case .Cubs: return "CHC"
        case .Reds: return "CIN"
        case .Guardings: return "CLE"
        case .Rockies: return "COL"
        case .Tigers: return "DET"
        case .Astros: return "HOU"
        case .Royals: return "KC"
        case .Angels: return "LAA"
        case .Dodgers: return "LAD"
        case .Marlins: return "MIA"
        case .Brewers: return "MIL"
        case .Twins: return "MIN"
        case .Yankees: return "NYY"
        case .Mets: return "NYM"
        case .Athletics: return "OAK"
        case .Phillies: return "PHI"
        case .Pirates: return "PIT"
        case .Padres: return "SD"
        case .Giants: return "SF"
        case .Mariners: return "SEA"
        case .Cardinals: return "STL"
        case .Rays: return "TB"
        case .Rangers: return "TEX"
        case .BlueJays: return "TOR"
        case .Nationals: return "WSH"
        }
    }
    
    var fullText: String {
        switch self {
        case .Diamondbacks: return "Arizona Diamondbacks"
        case .Braves: return "Atlanta Braves"
        case .Orioles: return "Baltimore Orioles"
        case .RedSox: return "Boston Red Sox"
        case .WhiteSox: return "Chicago White Sox"
        case .Cubs: return "Chicago Cubs"
        case .Reds: return "Cincinatti Reds"
        case .Guardings: return "Cleveland Guardians"
        case .Rockies: return "Colorado Rockies"
        case .Tigers: return "Detroit Tigers"
        case .Astros: return "Houston Astros"
        case .Royals: return "Kansas City Royals"
        case .Angels: return "Los Angeles Angels"
        case .Dodgers: return "Los Angeles Dodgers"
        case .Marlins: return "Miami Marlins"
        case .Brewers: return "Milwaukee Brewers"
        case .Twins: return "Minnesota Twins"
        case .Yankees: return "New York Yankees"
        case .Mets: return "New York Mets"
        case .Athletics: return "Oakland Athletics"
        case .Phillies: return "Philadelphia Phillies"
        case .Pirates: return "Pittsburgh Pirates"
        case .Padres: return "San Diego Padres"
        case .Giants: return "San Fransisco Giants"
        case .Mariners: return "Seattle Mariners"
        case .Cardinals: return "St Louis Cardinals"
        case .Rays: return "Tampa Bay Rays"
        case .Rangers: return "Texas Rangers"
        case .BlueJays: return "Toronto Blue Jays"
        case .Nationals: return "Washington Nationals"
        }
    }
}
