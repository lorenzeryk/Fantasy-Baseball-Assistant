//
//  PlayerSummaryView.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 3/31/23.
//

import SwiftUI

struct PlayerSummaryView: View {
    var viewModel: MainViewModel
    
    var body: some View {
        HStack {
            PlayerInfoView(viewModel: viewModel)
            Divider()
            HStack {
                StatSummaryView(viewModel: viewModel)
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
