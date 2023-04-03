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
    
    @State var selectedPlayer: Player? = nil
    
    var body: some View {
        NavigationView {
            List(players, id: \.self, selection: $selectedPlayer) { player in
                Text(String("\(player.first_name) \(player.last_name), \(player.primary_position.abbreviation) \(player.team.abbreviation)"))
            }
                .listStyle(.sidebar)
                .navigationTitle("Roster")
            
            CenterView()
        }.toolbar {
            ToolbarItem(placement: .navigation) {
                Button(action: toggleSidebar, label: {
                    Image(systemName: "sidebar.leading")
                })
            }
        }
    }
}

//TODO: cite from https://sarunw.com/posts/how-to-toggle-sidebar-in-macos/
private func toggleSidebar() {
    NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
}

struct topLevelView_Previews: PreviewProvider {
    @State static private var examplePlayers: [Player] = [Player(first_name: "Player", last_name: "One", team: Team.Rockies), Player(first_name: "Player", last_name: "Two", team: Team.BlueJays)]
    
    static var previews: some View {
        topLevelView(players: examplePlayers)
    }
}
