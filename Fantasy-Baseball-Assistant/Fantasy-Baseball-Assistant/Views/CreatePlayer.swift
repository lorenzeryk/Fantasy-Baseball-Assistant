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
    
    @State var failureMessage: String = ""
    @State var firstNameBorderColor: Color = Color.clear
    @State var lastNameBorderColor: Color = Color.clear
    @State var positionBorderColor: Color = Color.clear
    @State var teamBorderColor: Color = Color.clear
    
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
        VStack {
            HStack {
                Text("First Name:")
                TextField("First Name", text: $first_name)
                    .border(firstNameBorderColor)
            }
            HStack {
                Text("Last Name:")
                TextField("Last Name", text: $last_name)
                    .border(lastNameBorderColor)
            }
        }
    }
    
    @ViewBuilder private func Buttons() -> some View {
        HStack {
            Spacer()
            if (viewModel.failedPlayerValidation) {
                Text(failureMessage)
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
        HStack {
            Text("Primary Position:")
            Picker("Primary Position", selection: $selectedPosition) {
                ForEach(PlayerPosition.allCases, id: \.self) { position in
                    Text(position.fullText)
                    
                }
            }
            .border(positionBorderColor)
            .labelsHidden()
        }
        
        HStack {
            Text("Team:")
            Picker("Team", selection: $selectedTeam) {
                ForEach(Team.allCases, id: \.self) { team in
                    Text(team.fullText)
                }
            }
            .border(teamBorderColor)
            .labelsHidden()
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
        
        if (first_name == "" || last_name == "" || selectedPosition == PlayerPosition.None || selectedTeam == Team.None) {
            failureMessage = "All required fields must be populated"
            viewModel.failedPlayerValidation = true
            setBorderColors()
        } else {
            Task.init {
                let (playerStatus, errorMessage) = await viewModel.addPlayer(firstName: first_name, lastName: last_name, position: selectedPosition, team: selectedTeam, secondaryPositions: positions, dataRequester: dataRequester, persistenceController: persistenceController)
                if (playerStatus) {
                    stateManager.cancelCreatingPlayer()
                } else {
                    failureMessage = errorMessage ?? "Internal Error"
                }
            }
        }
    }
    
    private func cancelCreatingPlayer() {
        stateManager.cancelCreatingPlayer()
    }
    
    private func setBorderColors() {
        if (first_name == "") {
            firstNameBorderColor = Color.red
        } else {
            firstNameBorderColor = Color.clear
        }
        if (last_name == "") {
            lastNameBorderColor = Color.red
        } else {
            lastNameBorderColor = Color.clear
        }
        if (selectedPosition == PlayerPosition.None) {
            positionBorderColor = Color.red
        } else {
            positionBorderColor = Color.clear
        }
        if (selectedTeam == Team.None) {
            teamBorderColor = Color.red
        } else {
            teamBorderColor = Color.clear
        }
    }
}

//struct CreatePlayer_Previews: PreviewProvider {
//    static var previews: some View {
//        CreatePlayer()
//    }
//}
