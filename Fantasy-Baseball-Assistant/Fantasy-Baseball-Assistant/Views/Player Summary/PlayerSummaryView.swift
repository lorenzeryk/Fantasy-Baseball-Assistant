//
//  PlayerSummaryView.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 3/31/23.
//

import SwiftUI

struct PlayerSummaryView: View {
    @ObservedObject var selectedPlayer: Player
    
    var body: some View {
        HStack {
            PlayerInfoView(player: selectedPlayer)
            Divider()
            HStack {
                StatSummaryView(player: selectedPlayer)
                    .frame(maxWidth: .infinity)
                Divider()
                MatchupView()
            }
        }
    }
}

//struct PlayerSummaryView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlayerSummaryView()
//    }
//}
