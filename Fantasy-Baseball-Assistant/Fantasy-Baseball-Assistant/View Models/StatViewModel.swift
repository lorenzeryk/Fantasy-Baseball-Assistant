//
//  StatViewModel.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 4/14/23.
//

import Foundation

/// View Model that takes a player's stats and extracts the data to display to a user based on the currently selected options for the stats
class StatViewModel: ObservableObject {
    var currentPlayer: Player?
    
    /// The currently selected stat view. When updated updateSelectedStats is called to update the stats displayed to the user to correspond with their selection
    ///
    /// Defaults to Season on intiialization
    var selectedStatView: SelectedStatView = SelectedStatView.Season {
        didSet {
            updateSelectedStats()
        }
    }
    
    @Published var hittingSortOrder: [KeyPathComparator<FielderStatsBase>] = [
        .init(\.key, order: .forward)] {
            didSet {
                updateSelectedStats()
            }
        }
    
    /// Stats for the currently selected stat view for hitting statistics
    @Published var selectedHittingStats: [FielderStatsBase]
    
    @Published var pitchingSortOrder: [KeyPathComparator<PitcherStatsBase>] = [
        .init(\.key, order: .forward)] {
            didSet {
                updateSelectedStats()
            }
        }
    /// Stats for the currently selected stat view for pitching statistics
    @Published var selectedPitchingStats: [PitcherStatsBase]
    
    /// Boolean to control if basic or detailed stats are presented to the user
    @Published var displayAdvancedStats = false

    init(player: Player?) {
        currentPlayer = player
        selectedHittingStats = []
        selectedPitchingStats = []
        updateSelectedStats()
        registerForNotification()
    }
    
    /// Method to extract the data necessary to display the currently selected stat view from the all statistics for the current player
    @objc private func updateSelectedStats() {
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
            selectedPitchingStats.sort(using: pitchingSortOrder)
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
            selectedHittingStats.sort(using: hittingSortOrder)
        }
    }
    
    /// Method to get value for each key in the table
    ///
    /// If the selected stat view is month then returns a string of the month else returns the key value for opponent name of day/night
    ///
    /// - Parameters:
    ///   - stat: The current statistic object for that row in the table
    /// - Returns: A string for the key of that row of the table
    func translateKey(stat: FielderStatsBase) -> String {
        if (selectedStatView == SelectedStatView.Month) {
            return Month(rawValue: Int16(stat.key)!)!.text
        }
        if (selectedStatView == SelectedStatView.Opponent || selectedStatView == SelectedStatView.DayNight) {
            return stat.key
        }
        
        return ""
    }
    
    /// Method to get value for each key in the table
    ///
    /// If the selected stat view is month then returns a string of the month else returns the key value for opponent name of day/night
    ///
    /// - Parameters:
    ///   - stat: The current statistic object for that row in the table
    /// - Returns: A string for the key of that row of the table
    func translateKey(stat: PitcherStatsBase) -> String {
        if (selectedStatView == SelectedStatView.Month) {
            return Month(rawValue: Int16(stat.key)!)!.text
        }
        if (selectedStatView == SelectedStatView.Opponent || selectedStatView == SelectedStatView.DayNight) {
            return stat.key
        }
        
        return ""
    }
    
    /// Method to return the label for the currently selected stat view
    ///
    ///  The returned value is:
    ///    - Stat View is Month -> returns "Month"
    ///    - Stat View is Opponent -> returns "Opponent"
    ///    - Stat View is DayNight -> returns "Time of Day"
    ///
    ///  - Returns: String for the label in the table for the key
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
    
    /// Register to get notifications for when a player's stats update
    func registerForNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateSelectedStats), name: .statsUpdated, object: nil)
    }
}

/// The currently selected stat view
enum SelectedStatView {
    case Season
    case Month
    case DayNight
    case Opponent
}

/// Used to translate month for stats from integer to string representation
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
