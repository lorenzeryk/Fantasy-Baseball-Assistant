//
//  HitterStatSummaryView.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 3/31/23.
//

import SwiftUI

struct HitterStatSummaryView: View {
    @ObservedObject var player: Player
    
    var body: some View {
        HStack {
            if (player.stats?.season.hitting_stats != nil) {
                firstSection()
                Divider()
                secondSection()
                Divider()
                thirdSection()
            } else {
                Text("No hitting stats found")
            }
        }
    }
    
    //TODO: change func names
    @ViewBuilder private func firstSection() -> some View {
        VStack {
            Text("WAR")
            Text(String(format: "%.1f", player.stats!.season.hitting_stats!.WAR))
        }
        VStack {
            Text("AB")
            Text(String(player.stats!.season.hitting_stats!.AB))
        }
        VStack {
            Text("H")
            Text(String(player.stats!.season.hitting_stats!.hits))
        }
        VStack {
            Text("HR")
            Text(String(player.stats!.season.hitting_stats!.homeruns))
        }
        VStack {
            Text("BA")
            Text(String(format: "%.3f", player.stats!.season.hitting_stats!.batting_average))
        }
    }
    
    @ViewBuilder private func secondSection() -> some View {
        VStack {
            Text("R")
            Text(String(player.stats!.season.hitting_stats!.runs))
        }
        VStack {
            Text("RBI")
            Text(String(player.stats!.season.hitting_stats!.RBI))
        }
        VStack {
            Text("SB")
            Text(String(player.stats!.season.hitting_stats!.stolen_bases))
        }
    }
    
    @ViewBuilder private func thirdSection() -> some View {
        VStack {
            Text("OBP")
            Text(String(format: "%.3f", player.stats!.season.hitting_stats!.OBP))
        }
        VStack {
            Text("SLG")
            Text(String(format: "%.3f", player.stats!.season.hitting_stats!.SLG))
        }
        VStack {
            Text("OPS")
            Text(String(format: "%.3f", player.stats!.season.hitting_stats!.OPS))
        }
        VStack {
            Text("OPS+")
            Text(String(format: "%.3f", player.stats!.season.hitting_stats!.OPS_plus))
        }
    }
}

//struct HitterStatSummaryView_Previews: PreviewProvider {
//    static var previews: some View {
//        HitterStatSummaryView()
//    }
//}
