//
//  PlayerInfoView.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 3/31/23.
//

import SwiftUI

struct PlayerInfoView: View {
    var testPlayer: Player = Player(first_name: "Derek", last_name: "Jeter", team: Team.Yankees, primary_position: PlayerPosition.Short, positions: [PlayerPosition.Short, PlayerPosition.Second])
    
    
    var body: some View {
        VStack {
            Text(testPlayer.first_name)
                .font(.system(size: 40))
            Text(testPlayer.last_name)
                .font(.system(size: 40))
            Text(testPlayer.primary_position.fullText)
                .font(.system(size: 24))
            Text("Secondary Positions: \(getAllPlayerPositions(player: testPlayer))")
            Text(testPlayer.team.fullText)
        }
        
        
//        HStack {
//            VStack {
//                HStack {
//                    Text(testPlayer.first_name)
//                        .font(.system(size: 32))
//                    Text(testPlayer.last_name)
//                        .font(.system(size: 32))
//                }
//                HStack {
//                    VStack {
//                        Text(testPlayer.primary_position.fullText)
//                        Text("Secondary Positions: \(getAllPlayerPositions(player: testPlayer))")
//                        Text(testPlayer.team.fullText)
//                    }
//                }
//            }
//        }
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

struct PlayerInfoView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerInfoView()
    }
}
