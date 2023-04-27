//
//  PlayerInfoView.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 3/31/23.
//

import SwiftUI

/// View that shows basic player information including name and team
struct PlayerInfoView: View {
    @ObservedObject var player: Player
    
    var body: some View {
        VStack {
            Text(player.first_name)
                .font(.system(size: 40))
            Text(player.last_name)
                .font(.system(size: 40))
            Text(player.primary_position.fullText)
                .font(.system(size: 24))
            Text("Secondary Positions: \(getAllPlayerPositions(player: player))")
            Text(player.team.fullText)
        }
        .padding()
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

//struct PlayerInfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlayerInfoView()
//    }
//}
