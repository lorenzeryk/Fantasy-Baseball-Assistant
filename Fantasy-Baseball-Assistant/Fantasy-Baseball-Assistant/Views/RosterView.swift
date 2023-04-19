//
//  RosterView.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 4/3/23.
//

import SwiftUI

struct RosterView: View {
    @ObservedObject var viewModel: RosterViewModel
    @ObservedObject var stateManager: StateManager
    
    var body: some View {
        RosterTables()
    }
    
#warning ("TODO: cite from https://useyourloaf.com/blog/context-menus-for-tables/")
    @ViewBuilder private func RosterTables() -> some View {
        PitchersTable()
        .contextMenu(forSelectionType: Player.ID.self) { player in
            
        } primaryAction: { player in
            
            stateManager.updateShowPlayerInfo(selectedPlayer: viewModel.roster.getPlayerByID(playerID: stateManager.selectedPlayerID!))
        }
        Divider()
        Spacer()
        HittersTable()
        .contextMenu(forSelectionType: Player.ID.self) { player in

        } primaryAction: { player in
            stateManager.updateShowPlayerInfo(selectedPlayer: viewModel.roster.getPlayerByID(playerID: stateManager.selectedPlayerID!))
        }
    }
    
    @ViewBuilder private func PitchersTable() -> some View {
        Text("Pitchers")
            .padding()
        Table(viewModel.roster.pitchers, selection: $stateManager.selectedPlayerID) {
            TableColumn("Name") {
                Text($0.first_name + " " + $0.last_name)
            }
            TableColumn("Primary Position") {
                Text($0.primary_position.fullText)
            }
            TableColumn("Secondary Positions") {
                Text(getAllPlayerPositions(player: $0))
            }
            TableColumn("Team") {
                Text($0.team.fullText)
            }
        }

    }
    
    @ViewBuilder private func HittersTable() -> some View {
        Text("Fielders")
            .padding()
        Table(viewModel.roster.hitters, selection: $stateManager.selectedPlayerID) {
            TableColumn("Name") {
                Text($0.first_name + " " + $0.last_name)
            }
            TableColumn("Primary Position") {
                Text($0.primary_position.fullText)
            }
            TableColumn("Secondary Positions") {
                Text(getAllPlayerPositions(player: $0))
            }
            TableColumn("Team") {
                Text($0.team.fullText)
            }
        }
    }
    
    private func getAllPlayerPositions(player: Player) -> String {
        if (player.positions.isEmpty) {
            return "None"
        }
        
        var allPositions = ""
        for position in player.positions {
            if (position != player.primary_position) {
                allPositions += (position.abbreviation + ", ")
            }
        }
        
        return String(allPositions.dropLast().dropLast())
    }
}

//struct RosterView_Previews: PreviewProvider {
//    static var previews: some View {
//        RosterView()
//    }
//}
