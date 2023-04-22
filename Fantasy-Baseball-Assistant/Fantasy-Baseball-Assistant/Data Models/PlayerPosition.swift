//
//  PlayerPosition.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 3/30/23.
//

import Foundation

enum PlayerPosition: Int16, CaseIterable {
    case None = 0
    case SP = 1
    case RP = 2
    case C = 3
    case First = 4
    case Second = 5
    case Third = 6
    case Short = 7
    case Left = 8
    case Center = 9
    case Right = 10
    
}

extension PlayerPosition {
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
        case .First: return "First Base"
        case .Second: return "Second Base"
        case .Third: return "Third Base"
        case .Short: return "Shortstop"
        case .Left: return "Left Field"
        case .Center: return "Center Field"
        case .Right: return "Right Field"
        case .None: return ""
        }
    }
}
