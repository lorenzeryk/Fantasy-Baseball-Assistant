//
//  CreatePlayer.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 4/3/23.
//

import SwiftUI

struct CreatePlayer: View {
    @ObservedObject var viewModel: MainViewModel
    @ObservedObject var stateManager: StateManager
    
    @State var first_name: String = ""
    @State var last_name: String = ""
    @State var selectedPosition = PlayerPosition.None
    @State var selectedTeam = Team.None

    @State var secondaryPositions: [PlayerPositionBinding] = [
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
    
    var body: some View {
        VStack {
            getName()
            enumPickers()
            secondaryPositionsSelecter()
                .padding()
            Buttons()
            Spacer()
        }
        .padding()
    }
    
    @ViewBuilder private func getName() -> some View {
        HStack {
            HStack {
                Text("First Name:")
                TextField("First Name", text: $first_name)
            }
            HStack {
                Text("Last Name:")
                TextField("Last Name", text: $last_name)
            }
        }
    }
    
    @ViewBuilder private func Buttons() -> some View {
        HStack {
            Spacer()
            if (viewModel.failedPlayerValidation) {
                Text("Failed to validate player")
                    .foregroundColor(.red)
            }
            Button("Submit") {
                submitCreatedPlayer()
            }
            Button("Cancel") {
                cancelCreatingPlayer()
            }
        }
    }
    
    @ViewBuilder private func enumPickers() -> some View {
        Picker("Primary Position", selection: $selectedPosition) {
            ForEach(PlayerPosition.allCases, id: \.self) { position in
                Text(position.fullText)
            }
        }
        Picker("Team", selection: $selectedTeam) {
            ForEach(Team.allCases, id: \.self) { team in
                Text(team.fullText)
            }
        }
    }
    
    @ViewBuilder private func secondaryPositionsSelecter() -> some View {
        VStack {
            Text("Secondary Positions")
            List(secondaryPositions) { secondaryPosition in
                Toggle(secondaryPosition.position.fullText, isOn: $secondaryPositions[Int(secondaryPosition.position.rawValue)-1].selected)
                    .toggleStyle(.switch)
            }
        }
    }
    
    private func submitCreatedPlayer() {
        let positions = createSecondaryPositionArray()
        Task.init {
            let playerStatus = await viewModel.addPlayer(firstName: first_name, lastName: last_name, position: selectedPosition, team: selectedTeam, secondaryPositions: positions)
            if (playerStatus) {
                stateManager.cancelCreatingPlayer()
            }
        }
    }
    
    private func cancelCreatingPlayer() {
        stateManager.cancelCreatingPlayer()
    }
    
    private func createSecondaryPositionArray() -> [PlayerPosition]? {
        var secondaryPositionsSelected: [PlayerPosition] = []
        for position in secondaryPositions {
            if (position.selected && position.position != selectedPosition) {
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

//struct CreatePlayer_Previews: PreviewProvider {
//    static var previews: some View {
//        CreatePlayer()
//    }
//}
