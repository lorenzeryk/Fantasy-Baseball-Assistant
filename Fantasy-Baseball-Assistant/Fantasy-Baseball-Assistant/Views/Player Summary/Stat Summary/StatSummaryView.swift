//
//  StatSummaryView.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 3/31/23.
//

import SwiftUI

struct StatSummaryView: View {
    //TODO: Determine solution to have stats update when player stats update
    @ObservedObject var player: Player
    
    var body: some View {
        VStack {
            Text("Season Stat Summary")
                .font(.system(size: 32))
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
