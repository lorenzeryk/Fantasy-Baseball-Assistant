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
            Text("WAR")
            Text(String(format: "%.1f", player.pitchingStats!.season.WAR))
        }
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
            Text(String(format: "%.2f", player.pitchingStats!.season.ERA))
        }
    }
    
    @ViewBuilder private func secondSection() -> some View {
        VStack {
            Text("Games")
            Text(String(player.pitchingStats!.season.games_pitched))
        }
        VStack {
            Text("Games Started")
            Text(String(player.pitchingStats!.season.games_started))
        }
        VStack {
            Text("Saves")
            Text(String(player.pitchingStats!.season.saves))
        }
    }
    
    @ViewBuilder private func thirdSection() -> some View {
        VStack {
            Text("Innings Pitched")
            Text(String(format: "%.1f", player.pitchingStats!.season.ERA))
        }
        VStack {
            Text("Strikeouts")
            Text(String(player.pitchingStats!.season.strikeouts))
        }
        VStack {
            Text("WHIP")
            Text(String(format: "%.2f", player.pitchingStats!.season.ERA))
        }
    }
}

//struct PitcherStatSummaryView_Previews: PreviewProvider {
//    static var previews: some View {
//        PitcherStatSummaryView()
//    }
//}
