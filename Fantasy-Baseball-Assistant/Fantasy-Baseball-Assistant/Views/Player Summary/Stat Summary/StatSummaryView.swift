//
//  StatSummaryView.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 3/31/23.
//

import SwiftUI

/// Top Level View for displaying a quick summary of a player's season statistics. Creates sub view based on if player is a pitcher or hitter
struct StatSummaryView: View {
    #warning ("TODO: Determine solution to have stats update when player stats update")
    @ObservedObject var player: Player
    
    var body: some View {
        VStack {
            Text("Season Stat Summary")
                .font(.system(size: 32))
                .padding()
            if (player.isPitcher()) {
                PitcherStatSummaryView(player: player)
            } else {
                HitterStatSummaryView(player: player)
            }
        }
    }
}

//struct StatSummaryView_Previews: PreviewProvider {
//    static var previews: some View {
//        StatSummaryView()
//    }
//}
