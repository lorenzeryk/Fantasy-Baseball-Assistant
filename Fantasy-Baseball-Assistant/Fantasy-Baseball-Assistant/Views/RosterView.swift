//
//  RosterView.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 4/3/23.
//

import SwiftUI

struct RosterView: View {
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        RosterTables()
    }
    
    @ViewBuilder private func RosterTables() -> some View {
        PitchersTable()
        //TODO: cite from https://useyourloaf.com/blog/context-menus-for-tables/
        .contextMenu(forSelectionType: Player.ID.self) { player in
            
        } primaryAction: { player in
            
            viewModel.updateShowPlayerInfo()
        }
        Spacer()
        HittersTable()
        //TODO: cite from https://useyourloaf.com/blog/context-menus-for-tables/
        .contextMenu(forSelectionType: Player.ID.self) { player in

        } primaryAction: { player in
            viewModel.updateShowPlayerInfo()
        }
    }
    
    @ViewBuilder private func PitchersTable() -> some View {
        Text("Pitchers")
        Table(viewModel.roster.pitchers, selection: $viewModel.selectedPlayerID) {
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
        Table(viewModel.roster.hitters, selection: $viewModel.selectedPlayerID) {
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
        if (player.positions.isEmpty || player.positions.count == 1) {
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
