//
//  RosterView.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 4/3/23.
//

import SwiftUI

/// View that displays a table of hitters and a table of pitchers currently in the roster
struct RosterView: View {
    @ObservedObject var viewModel: RosterViewModel
    @ObservedObject var stateManager: StateManager
    @Binding var hittingSortOrder: [KeyPathComparator<Player>]
    @Binding var pitcherSortOrder: [KeyPathComparator<Player>]
    
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
            .font(.system(size: 24))
            .padding()
        Table(viewModel.pitchers, selection: $stateManager.selectedPlayerID, sortOrder: $pitcherSortOrder) {
            TableColumn("Name", value: \.last_name) { player in
                Text(player.first_name + " " + player.last_name)
            }
            TableColumn("Primary Position", value: \.primary_position_raw) { player in
                Text(player.primary_position.fullText)
            }
            TableColumn("Secondary Positions") { player in
                Text(getAllPlayerPositions(player: player))
            }
            TableColumn("Team", value: \.team.fullText) { player in
                Text(player.team.fullText)
            }
        }

    }
    
    @ViewBuilder private func HittersTable() -> some View {
        Text("Hitters")
            .font(.system(size: 24))
            .padding()
        Table(viewModel.hitters, selection: $stateManager.selectedPlayerID, sortOrder: $hittingSortOrder) {
            TableColumn("Name", value: \.last_name) { player in
                Text(player.first_name + " " + player.last_name)
            }
            TableColumn("Primary Position", value: \.primary_position_raw) { player in
                Text(player.primary_position.fullText)
            }
            TableColumn("Secondary Positions") { player in
                Text(getAllPlayerPositions(player: player))
            }
            TableColumn("Team", value: \.team.fullText) { player in
                Text(player.team.fullText)
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
