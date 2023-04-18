//
//  CreatePlayer.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 4/3/23.
//

import SwiftUI

struct CreatePlayer: View {
    @EnvironmentObject var viewModel: RosterViewModel
    @EnvironmentObject var stateManager: StateManager
    @EnvironmentObject var dataRequester: DataRequester
    @EnvironmentObject var persistenceController: PersistenceController
    
    @State var createPlayer: CreatePlayerViewModel = CreatePlayerViewModel()
    @State var first_name: String = ""
    @State var last_name: String = ""
    @State var selectedPosition: PlayerPosition = PlayerPosition.None
    @State var selectedTeam = Team.None
    
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
            List(createPlayer.secondaryPositions) { secondaryPosition in
                Toggle(secondaryPosition.position.fullText, isOn: $createPlayer.secondaryPositions[Int(secondaryPosition.position.rawValue)-1].selected)
                    .toggleStyle(.switch)
            }
        }
    }
    
    private func submitCreatedPlayer() {
        let positions = createPlayer.createSecondaryPositionArray(selectedPrimary: selectedPosition)
        Task.init {
            let playerStatus = await viewModel.addPlayer(firstName: first_name, lastName: last_name, position: selectedPosition, team: selectedTeam, secondaryPositions: positions, dataRequester: dataRequester, persistenceController: persistenceController)
            if (playerStatus) {
                stateManager.cancelCreatingPlayer()
            }
        }
    }
    
    private func cancelCreatingPlayer() {
        stateManager.cancelCreatingPlayer()
    }
}

//struct CreatePlayer_Previews: PreviewProvider {
//    static var previews: some View {
//        CreatePlayer()
//    }
//}
