//
//  StatSummaryView.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 3/31/23.
//

import SwiftUI

struct StatSummaryView: View {
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        VStack {
            Text("Season Stat Summary")
                .font(.system(size: 32))
            if (viewModel.showPlayerInfo) {
                if (viewModel.selectedPlayer!.isPitcher()) {
                    PitcherStatSummaryView(viewModel: viewModel)
                } else {
                    HitterStatSummaryView(viewModel: viewModel)
                }
            }
        }
    }
}

//struct StatSummaryView_Previews: PreviewProvider {
//    static var previews: some View {
//        StatSummaryView()
//    }
//}
