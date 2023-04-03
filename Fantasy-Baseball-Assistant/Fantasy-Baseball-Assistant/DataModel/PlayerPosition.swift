//
//  PlayerPosition.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 3/30/23.
//

import Foundation

enum PlayerPosition: Int {
    case RP = 0
    case SP = 1
    case C = 2
    case First = 3
    case Second = 4
    case Third = 5
    case Short = 6
    case Left = 7
    case Center = 8
    case Right = 9
    case None = 10
    
    var abbreviation: String {
        switch self {
        case .RP: return "RP"
        case .SP: return "SP"
        case .C: return "C"
        case .First: return "1B"
        case .Second: return "2B"
        case .Third: return "3B"
        case .Short: return "SS"
        case .Left: return "LF"
        case .Center: return "CF"
        case .Right: return "RF"
        case .None: return "NP"
        }
    }
    
    var fullText: String {
        switch self {
        case .RP: return "Relief Pitcher"
        case .SP: return "Starting Pitcher"
        case .C: return "Catcher"
        case .First: return "First Basem"
        case .Second: return "Second Base"
        case .Third: return "Third Base"
        case .Short: return "Shortstop"
        case .Left: return "Left Field"
        case .Center: return "Center Field"
        case .Right: return "Right Field"
        case .None: return "No Position"
        }
    }
}
