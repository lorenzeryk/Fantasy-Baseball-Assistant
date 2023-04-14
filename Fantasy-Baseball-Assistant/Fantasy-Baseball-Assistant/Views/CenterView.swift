//
//  CenterView.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 3/31/23.
//

import SwiftUI

struct CenterView: View {
    @EnvironmentObject var rosterViewModel: RosterViewModel
    @EnvironmentObject var stateManager: StateManager
    
    var body: some View {
        if (stateManager.displayCreatePlayerView) {
            CreatePlayer()
        } else {
            if (stateManager.showPlayerInfo) {
                VStack {
                    PlayerSummaryView(selectedPlayer: stateManager.selectedPlayer!)
                        .frame(maxHeight: 150)
                    Divider()
                    MainStatView(statViewModel: StatViewModel(player: stateManager.selectedPlayer))
                }
            }
            else {
                RosterView(viewModel: rosterViewModel, stateManager: stateManager)
            }
        }
    }
}


//struct CenterView_Previews: PreviewProvider {
//    static var previews: some View {
//        CenterView()
//    }
//}
