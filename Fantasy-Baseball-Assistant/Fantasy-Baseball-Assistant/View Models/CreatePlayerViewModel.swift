//
//  CreatePlayerViewModel.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 4/12/23.
//

import Foundation

/// View Model used to display and store selected secondary positions when adding a player
class CreatePlayerViewModel: ObservableObject {
    /// Array that contains the value of each switch and its corresponding player position value on the create player view when selecting secondary positions
    var secondaryPositions: [PlayerPositionBinding] = [
        PlayerPositionBinding(id: 1,position: PlayerPosition(rawValue: 1)!, selected: false),
        PlayerPositionBinding(id: 2,position: PlayerPosition(rawValue: 2)!, selected: false),
        PlayerPositionBinding(id: 3,position: PlayerPosition(rawValue: 3)!, selected: false),
        PlayerPositionBinding(id: 4,position: PlayerPosition(rawValue: 4)!, selected: false),
        PlayerPositionBinding(id: 5,position: PlayerPosition(rawValue: 5)!, selected: false),
        PlayerPositionBinding(id: 6,position: PlayerPosition(rawValue: 6)!, selected: false),
        PlayerPositionBinding(id: 7,position: PlayerPosition(rawValue: 7)!, selected: false),
        PlayerPositionBinding(id: 8,position: PlayerPosition(rawValue: 8)!, selected: false),
        PlayerPositionBinding(id: 9,position: PlayerPosition(rawValue: 9)!, selected: false),
        PlayerPositionBinding(id: 10,position: PlayerPosition(rawValue: 10)!, selected: false)
    ]
    
    /// Builds the array of secondary positions selected by the user when creating a player
    ///
    /// - Parameters:
    ///   - selectedPrimary: The selected value for the primary position. This value is omitted from the selected secondary positions
    ///
    /// - Returns: An array of the all the selected secondary positions or nil if none or only the same as the primary position are selected
    func createSecondaryPositionArray(selectedPrimary: PlayerPosition) -> [PlayerPosition]? {
        var secondaryPositionsSelected: [PlayerPosition] = []
        for position in secondaryPositions {
            if (position.selected && position.position != selectedPrimary) {
                secondaryPositionsSelected.append(position.position)
            }
        }
        if (secondaryPositionsSelected.count == 0) {
            return nil
        }
        
        return secondaryPositionsSelected
    }
}

/// Used to display and collect selected secondary positions on the create player view
struct PlayerPositionBinding: Identifiable {
    var id: Int
    var position: PlayerPosition
    var selected: Bool
}
