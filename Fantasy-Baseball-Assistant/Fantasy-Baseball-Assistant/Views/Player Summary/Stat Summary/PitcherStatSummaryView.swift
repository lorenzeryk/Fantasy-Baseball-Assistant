//
//  PitcherStatSummaryView.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 3/31/23.
//

import SwiftUI

struct PitcherStatSummaryView: View {
    @ObservedObject var player: Player
    
    var body: some View {
        if (player.pitchingStats?.season != nil) {
            HStack {
                firstSection()
                Divider()
                secondSection()
                Divider()
                thirdSection()
            }
        } else {
            Text("No pitching stats found")
        }
    }
    
    //TODO: change func names
    @ViewBuilder private func firstSection() -> some View {
        VStack {
            Text("Win")
            Text(String(player.pitchingStats!.season.win))
        }
        VStack {
            Text("Loss")
            Text(String(player.pitchingStats!.season.loss))
        }
        VStack {
            Text("ERA")
            Text(String(format: "%.2f", player.pitchingStats!.season.era))
        }
    }
    
    @ViewBuilder private func secondSection() -> some View {
        VStack {
            Text("Innings Pitched")
            Text(String(format: "%.1f", player.pitchingStats!.season.ip_2))
        }
        VStack {
            Text("Saves")
            Text(String(player.pitchingStats!.season.save))
        }
        VStack {
            Text("Save Opportunities")
            Text(String(player.pitchingStats!.season.svo))
        }
    }
    
    @ViewBuilder private func thirdSection() -> some View {
        VStack {
            Text("WHIP")
            Text(String(format: "%.2f", player.pitchingStats!.season.whip))
        }
        VStack {
            Text("Strikeouts")
            Text(String(player.pitchingStats!.season.ktotal))
        }
        VStack {
            Text("Walks")
            Text(String(player.pitchingStats!.season.bb))
        }
    }
}

//struct PitcherStatSummaryView_Previews: PreviewProvider {
//    static var previews: some View {
//        PitcherStatSummaryView()
//    }
//}
