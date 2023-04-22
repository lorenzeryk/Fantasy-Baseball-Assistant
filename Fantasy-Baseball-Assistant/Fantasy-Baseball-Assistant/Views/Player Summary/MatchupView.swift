//
//  MatchupView.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 3/31/23.
//

import SwiftUI

struct MatchupView: View {
    var body: some View {
        VStack {
            Text("Matchup Today")
                .font(.system(size: 32))
            Text("Opponent: Los Angeles Dodgers")
            Text("Start Time: 6:40PM")
            Text("Status: Starting")
        }
    }
}

struct MatchupView_Previews: PreviewProvider {
    static var previews: some View {
        MatchupView()
    }
}
