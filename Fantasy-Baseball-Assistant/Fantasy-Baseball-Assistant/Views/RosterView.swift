//
//  RosterView.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 4/3/23.
//

import SwiftUI

struct RosterView: View {
    @ObservedObject var viewModel: MainViewModel
    
    @State var selected: Player.ID? = nil
    
    var body: some View {
        Text("Pitchers")
        Table(viewModel.roster.pitchers, selection: $selected) {
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
        .contextMenu(forSelectionType: Player.ID.self) { player in
            
        } primaryAction: { player in
            viewModel.setSelectionFromTable(player: player)
        }
        
        Spacer()
        Text("Fielders")
        Table(viewModel.roster.hitters, selection: $selected) {
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
        .contextMenu(forSelectionType: Player.ID.self) { player in
            
        } primaryAction: { player in
            viewModel.setSelectionFromTable(player: player)
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
