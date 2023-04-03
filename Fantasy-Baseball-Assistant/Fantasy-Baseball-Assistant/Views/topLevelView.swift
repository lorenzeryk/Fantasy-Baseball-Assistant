//
//  topLevelView.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 3/30/23.
//

import SwiftUI

struct topLevelView: View {
    //TODO: change later. currently just used for testing purposes
    var players: [Player] = [Player(first_name: "Player", last_name: "One", team: Team.Rockies, primary_position: PlayerPosition.SP), Player(first_name: "Player", last_name: "Two", team: Team.BlueJays, primary_position: PlayerPosition.Center)]
    
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.roster.players, id: \.self, selection: $viewModel.selectedPlayer) { player in
                Text(String("\(player.first_name) \(player.last_name), \(player.primary_position.abbreviation) \(player.team.abbreviation)"))
            }
                .listStyle(.sidebar)
                .navigationTitle("Roster")
            
            CenterView(rosterViewModel: viewModel)
        }.toolbar {
            ToolbarItem(placement: .navigation) {
                Button(action: toggleSidebar, label: {
                    Image(systemName: "sidebar.leading")
                })
            }
            ToolbarItem(placement: .navigation) {
                Button(action: loadTestData, label: {
                    Image(systemName: "plus")
                })
            }
        }
    }
    
    private func loadTestData() {
        viewModel.roster.createTestDataPlayers()
    }
}

//TODO: cite from https://sarunw.com/posts/how-to-toggle-sidebar-in-macos/
private func toggleSidebar() {
    NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
}

//struct topLevelView_Previews: PreviewProvider {
//    @State static private var examplePlayers: [Player] = [Player(first_name: "Player", last_name: "One", team: Team.Rockies), Player(first_name: "Player", last_name: "Two", team: Team.BlueJays)]
//
//    static var previews: some View {
//        topLevelView(players: examplePlayers)
//    }
//}
