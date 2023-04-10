//
//  topLevelView.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 3/30/23.
//

import SwiftUI

struct topLevelView: View {
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
            HomeToolbar(viewModel: viewModel)
        }
    }
}

struct HomeToolbar: ToolbarContent {
    @ObservedObject var viewModel: MainViewModel
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .navigation) {
            Button(action: toggleSidebar, label: {
                Image(systemName: "sidebar.leading")
            })
        }
        ToolbarItem(placement: .navigation) {
            Button(action: createPlayer, label: {
                Image(systemName: "plus")
            })
        }
        if (viewModel.showPlayerInfo) {
            ToolbarItem(placement: .navigation) {
                Button(action: backButton, label: {
                    Image(systemName: "chevron.backward")
                })
            }
        }
        if (viewModel.selectedPlayer != nil && !viewModel.showPlayerInfo) {
            ToolbarItem(placement: .navigation) {
                Button(action: deletePlayer, label: {
                    Image(systemName: "minus")
                })
            }
        }
    }
    
    private func createPlayer() {
        viewModel.setCreatePlayerStatus(true)
    }
    
    private func backButton() {
        viewModel.clearSelection()
    }
    
    private func deletePlayer() {
        viewModel.deleteSelectedPlayer()
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
