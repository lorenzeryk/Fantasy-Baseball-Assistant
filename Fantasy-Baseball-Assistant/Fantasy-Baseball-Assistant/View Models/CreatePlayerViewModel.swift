//
//  CreatePlayerViewModel.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 4/12/23.
//

import Foundation

class CreatePlayerViewModel: ObservableObject {    
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

struct PlayerPositionBinding: Identifiable {
    var id: Int
    var position: PlayerPosition
    var selected: Bool
}
