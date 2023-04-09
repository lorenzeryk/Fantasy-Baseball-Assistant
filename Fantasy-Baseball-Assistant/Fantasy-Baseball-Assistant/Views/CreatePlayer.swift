//
//  CreatePlayer.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 4/3/23.
//

import SwiftUI

struct CreatePlayer: View {
    @ObservedObject var viewModel: MainViewModel
    @State var first_name: String = ""
    @State var last_name: String = ""
    @State var selectedPosition = PlayerPosition.None
    @State var selectedTeam = Team.Angels
    @State var validationInProgress = true
    
    var body: some View {
        VStack {
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
            HStack {
                Spacer()
                if (viewModel.failedPlayerValidation) {
                    Text("Failed to validate player")
                        .foregroundColor(.red)
                }
                if (validationInProgress) {
                    //TODO: add loading icon
                }
                Button("Submit") {
                    submitCreatedPlayer()
                }
                Button("Cancel") {
                    cancelCreatingPlayer()
                }
            }
            Spacer()
        }
        .padding()
    }
    
    private func submitCreatedPlayer() {
        viewModel.addPlayer(firstName: first_name, lastName: last_name, position: selectedPosition, team: selectedTeam)
    }
    
    private func cancelCreatingPlayer() {
        viewModel.cancelCreatingPlayer()
    }
}

//struct CreatePlayer_Previews: PreviewProvider {
//    static var previews: some View {
//        CreatePlayer()
//    }
//}
