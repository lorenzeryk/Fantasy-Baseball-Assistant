//
//  CenterView.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 3/31/23.
//

import SwiftUI

struct CenterView: View {
    @ObservedObject var rosterViewModel: MainViewModel
    @ObservedObject var stateManager: StateManager
    
    var body: some View {
        if (stateManager.displayCreatePlayerView) {
            CreatePlayer(viewModel: rosterViewModel, stateManager: stateManager)
        } else {
            if (stateManager.showPlayerInfo) {
                VStack {
                    PlayerSummaryView(selectedPlayer: stateManager.selectedPlayer!)
                        .frame(maxHeight: 150)
                    Divider()
                    HStack {
                        Button("Season") {}
                        Button("Month") {}
                        Button("Week") {}
                        Button("Splits") {}
                        Button("Game Log") {}
                    }
                    Divider()
                    TestStatView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
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
