//
//  StatViewModel.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 4/14/23.
//

import Foundation

class StatViewModel: ObservableObject {
    var currentPlayer: Player?
    var selectedStatView: SelectedStatView = SelectedStatView.Season {
        didSet {
            updateSelectedStats()
        }
    }
    
    @Published var selectedHittingStats: [FielderStatsBase]
    @Published var selectedPitchingStats: [PitcherStatsBase]
    
    init() {
        currentPlayer = nil
        selectedHittingStats = []
        selectedPitchingStats = []
    }
    
    init(player: Player?) {
        currentPlayer = player
        selectedHittingStats = []
        selectedPitchingStats = []
        updateSelectedStats()
    }
    
    private func updateSelectedStats() {
        guard currentPlayer != nil else {
            return
        }
        
        guard currentPlayer!.hittingStats != nil else {
            return
        }
        
        if currentPlayer!.isPitcher() {
            selectedPitchingStats = []
            switch selectedStatView {
            case .Season:
                return
            case .Month:
                return
            case .DayNight:
                return
            case .Opponent:
                return
            }
        } else {
            selectedHittingStats = []
            switch selectedStatView {
            case .Season:
                print("Season hitting stats selected")
                selectedHittingStats.append(currentPlayer!.hittingStats!.season)
            case .Month:
                selectedHittingStats.append(contentsOf: currentPlayer!.hittingStats!.month)
            case .DayNight:
                selectedHittingStats.append(contentsOf: currentPlayer!.hittingStats!.day_night)
            case .Opponent:
                selectedHittingStats.append(contentsOf: currentPlayer!.hittingStats!.byOpponent)
            }
        }
    }
}

enum SelectedStatView {
    case Season
    case Month
    case DayNight
    case Opponent
}

enum Month: Int16 {
    case January = 1
    case February = 2
    case March = 3
    case April = 4
    case May = 5
    case June = 6
    case July = 7
    case August = 8
    case September = 9
    case October = 10
    case November = 11
    case December = 12
    
    var text: String {
        switch self {
        case .January:
            return "January"
        case .February:
            return "February"
        case .March:
            return "March"
        case .April:
            return "April"
        case .May:
            return "May"
        case .June:
            return "June"
        case .July:
            return "July"
        case .August:
            return "August"
        case .September:
            return "September"
        case .October:
            return "October"
        case .November:
            return "November"
        case .December:
            return "December"
        }
    }
}
