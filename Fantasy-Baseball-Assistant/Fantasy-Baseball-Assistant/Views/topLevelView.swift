//
//  topLevelView.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 3/30/23.
//

import SwiftUI

/// Top Level View that has sidebar roster, toolbar, and creates Center View
struct topLevelView: View {
    @StateObject var viewModel: RosterViewModel = RosterViewModel()
    @EnvironmentObject var stateManager: StateManager
    @EnvironmentObject var dataRequester: DataRequester
    @EnvironmentObject var persistenceController: PersistenceController
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Pitchers")
                List(viewModel.pitchers, id: \.self.id, selection: $stateManager.selectedPlayerID) { player in
                    Text(String("\(player.first_name) \(player.last_name), \(player.primary_position.abbreviation) \(player.team.abbreviation)"))
                }
                .onAppear{
                    viewModel.initializeData(persistenceController: persistenceController, dataRequester: dataRequester)
                }
                .contextMenu(forSelectionType: Player.ID.self) { player in
                    
                } primaryAction: { player in
                    
                    stateManager.updateShowPlayerInfo(selectedPlayer: viewModel.roster.getPlayerByID(playerID: stateManager.selectedPlayerID!))
                }
                .listStyle(.sidebar)
                .navigationTitle("Roster")
                
                Text("Hitters")
                List(viewModel.hitters, id: \.self.id, selection: $stateManager.selectedPlayerID) { player in
                    Text(String("\(player.first_name) \(player.last_name), \(player.primary_position.abbreviation) \(player.team.abbreviation)"))
                }
                .contextMenu(forSelectionType: Player.ID.self) { player in
                    
                } primaryAction: { player in
                    
                    stateManager.updateShowPlayerInfo(selectedPlayer: viewModel.roster.getPlayerByID(playerID: stateManager.selectedPlayerID!))
                }
                .listStyle(.sidebar)
                .navigationTitle("Roster")
            }
            CenterView()
                .environmentObject(viewModel)
        }.toolbar {
            HomeToolbar(viewModel: viewModel)
        }
        .onAppear {
            stateManager.dataRequester = dataRequester
            stateManager.persistenceController = persistenceController
        }
    }
}

/// Toolbar that provides controls to the user including hide/show sidebar, creating a player, a back button, and deleting a player
struct HomeToolbar: ToolbarContent {
    @ObservedObject var viewModel: RosterViewModel
    @EnvironmentObject var stateManager: StateManager
    @EnvironmentObject var dataRequester: DataRequester
    @EnvironmentObject var persistenceController: PersistenceController
    
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
        if (stateManager.showPlayerInfo) {
            ToolbarItem(placement: .navigation) {
                Button(action: backButton, label: {
                    Image(systemName: "chevron.backward")
                })
            }
        }
        if (stateManager.selectedPlayerID != nil && !stateManager.showPlayerInfo) {
            ToolbarItem(placement: .navigation) {
                Button(action: deletePlayer, label: {
                    Image(systemName: "minus")
                })
            }
        }
    }
    
    private func createPlayer() {
        stateManager.setCreatePlayerStatus(true)
    }
    
    private func backButton() {
        stateManager.clearSelection()
    }
    
    private func deletePlayer() {
        if viewModel.deletePlayer(stateManager.selectedPlayerID, persistenceController: persistenceController) == true {
            stateManager.clearSelection()
        }
    }
}

#warning ("TODO: cite from https://sarunw.com/posts/how-to-toggle-sidebar-in-macos/")
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
