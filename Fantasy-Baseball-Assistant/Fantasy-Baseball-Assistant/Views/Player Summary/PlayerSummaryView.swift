//
//  PlayerSummaryView.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 3/31/23.
//

import SwiftUI

struct PlayerSummaryView: View {
    @ObservedObject var selectedPlayer: Player
    @EnvironmentObject var dataRequester: DataRequester
    @EnvironmentObject var persistenceController: PersistenceController
    
    var body: some View {
        HStack {
            PlayerInfoView(player: selectedPlayer)
            Divider()
            HStack {
                StatSummaryView(player: selectedPlayer)
                    .frame(maxWidth: .infinity)
                Divider()
                MatchupView(viewModel: MatchupViewModel(dataRequester: dataRequester, persistenceController: persistenceController, selectedPlayer: selectedPlayer))
            }
        }
    }
}

//struct PlayerSummaryView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlayerSummaryView()
//    }
//}
