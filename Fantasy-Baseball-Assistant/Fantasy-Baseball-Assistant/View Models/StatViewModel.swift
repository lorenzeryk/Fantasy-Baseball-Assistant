//
//  StatViewModel.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 4/14/23.
//

import Foundation

class StatViewModel: ObservableObject {
    //TODO: determine solution to have stats view update stats when player stats update
    var currentPlayer: Player?
    var selectedStatView: SelectedStatView = SelectedStatView.Season {
        didSet {
            updateSelectedStats()
        }
    }
    
    @Published var selectedHittingStats: [FielderStatsBase]
    @Published var selectedPitchingStats: [PitcherStatsBase]
    @Published var displayAdvancedStats = false
    
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
        
        if currentPlayer!.isPitcher() {
            guard currentPlayer!.pitchingStats != nil else {
                return
            }
            
            selectedPitchingStats = []
            switch selectedStatView {
            case .Season:
                selectedPitchingStats.append(currentPlayer!.pitchingStats!.season)
            case .Month:
                selectedPitchingStats.append(contentsOf: currentPlayer!.pitchingStats!.month)
            case .DayNight:
                selectedPitchingStats.append(contentsOf: currentPlayer!.pitchingStats!.day_night)
            case .Opponent:
                selectedPitchingStats.append(contentsOf: currentPlayer!.pitchingStats!.byOpponent)
            }
        } else {
            guard currentPlayer!.hittingStats != nil else {
                return
            }
            
            selectedHittingStats = []
            switch selectedStatView {
            case .Season:
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
    
    func translateKey(stat: FielderStatsBase) -> String {
        if (selectedStatView == SelectedStatView.Month) {
            return Month(rawValue: Int16(stat.key)!)!.text
        }
        if (selectedStatView == SelectedStatView.Opponent || selectedStatView == SelectedStatView.DayNight) {
            return stat.key
        }
        
        return ""
    }
    
    func getKey() -> String {
        if (selectedStatView == SelectedStatView.Month) {
            return "Month"
        }
        if (selectedStatView == SelectedStatView.Opponent) {
            return "Opponent"
        }
        if (selectedStatView == SelectedStatView.DayNight) {
            return "Time of Day"
        }
        
        return ""
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
