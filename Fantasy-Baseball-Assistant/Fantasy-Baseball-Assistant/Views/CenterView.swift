//
//  CenterView.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 3/31/23.
//

import SwiftUI

struct CenterView: View {
    @ObservedObject var rosterViewModel: MainViewModel
    
    var body: some View {
        if (rosterViewModel.displayCreatePlayerView) {
            CreatePlayer(viewModel: rosterViewModel)
        } else {
            if (rosterViewModel.showPlayerInfo) {
                VStack {
                    PlayerSummaryView(viewModel: rosterViewModel)
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
                RosterView(viewModel: rosterViewModel)
            }
        }
    }
    
    private func backButton() {
        rosterViewModel.clearSelection()
    }
}


//struct CenterView_Previews: PreviewProvider {
//    static var previews: some View {
//        CenterView()
//    }
//}
