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
            if (player.hittingStats?.season != nil) {
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
            Text(String(format: "%.1f", player.hittingStats!.season.WAR))
        }
        VStack {
            Text("AB")
            Text(String(player.hittingStats!.season.ab))
        }
        VStack {
            Text("H")
            Text(String(player.hittingStats!.season.hits))
        }
        VStack {
            Text("HR")
            Text(String(player.hittingStats!.season.homeruns))
        }
        VStack {
            Text("BA")
            Text(String(format: "%.3f", player.hittingStats!.season.batting_average))
        }
    }
    
    @ViewBuilder private func secondSection() -> some View {
        VStack {
            Text("R")
            Text(String(player.hittingStats!.season.runs))
        }
        VStack {
            Text("RBI")
            Text(String(player.hittingStats!.season.rbi))
        }
        VStack {
            Text("SB")
            Text(String(player.hittingStats!.season.stolen_bases))
        }
    }
    
    @ViewBuilder private func thirdSection() -> some View {
        VStack {
            Text("OBP")
            Text(String(format: "%.3f", player.hittingStats!.season.obp))
        }
        VStack {
            Text("SLG")
            Text(String(format: "%.3f", player.hittingStats!.season.slg))
        }
        VStack {
            Text("OPS")
            Text(String(format: "%.3f", player.hittingStats!.season.ops))
        }
        VStack {
            Text("OPS+")
            Text(String(format: "%.3f", player.hittingStats!.season.OPS_plus))
        }
    }
}

//struct HitterStatSummaryView_Previews: PreviewProvider {
//    static var previews: some View {
//        HitterStatSummaryView()
//    }
//}
