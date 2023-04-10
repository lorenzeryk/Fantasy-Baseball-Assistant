//
//  PlayerInfoView.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 3/31/23.
//

import SwiftUI

struct PlayerInfoView: View {
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        VStack {
            if (viewModel.showPlayerInfo) {
                Text(viewModel.selectedPlayer!.first_name)
                    .font(.system(size: 40))
                Text(viewModel.selectedPlayer!.last_name)
                    .font(.system(size: 40))
                Text(viewModel.selectedPlayer!.primary_position.fullText)
                    .font(.system(size: 24))
                Text("Secondary Positions: \(getAllPlayerPositions(player: viewModel.selectedPlayer!))")
                Text(viewModel.selectedPlayer!.team.fullText)
            }
        }
        .padding()
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

//struct PlayerInfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlayerInfoView()
//    }
//}
