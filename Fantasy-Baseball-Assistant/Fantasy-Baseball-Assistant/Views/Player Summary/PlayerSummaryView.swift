//
//  PlayerSummaryView.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 3/31/23.
//

import SwiftUI

struct PlayerSummaryView: View {
    var body: some View {
        HStack {
            PlayerInfoView()
            Divider()
            HStack {
                StatSummaryView()
                    .frame(maxWidth: .infinity)
                Divider()
                MatchupView()
                    .frame(maxWidth: .infinity)
            }
        }
    }
}

struct PlayerSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerSummaryView()
    }
}
