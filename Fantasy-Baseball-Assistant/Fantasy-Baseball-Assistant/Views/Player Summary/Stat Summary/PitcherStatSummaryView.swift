//
//  PitcherStatSummaryView.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 3/31/23.
//

import SwiftUI

struct PitcherStatSummaryView: View {
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        if (viewModel.selectedPlayer != nil && viewModel.selectedPlayer!.stats!.season.pitching_stats != nil) {
            HStack {
                firstSection()
                Divider()
                secondSection()
                Divider()
                thirdSection()
            }
        }
    }
    
    //TODO: change func names
    @ViewBuilder private func firstSection() -> some View {
        VStack {
            Text("WAR")
            Text(String(format: "%.1f", viewModel.selectedPlayer!.stats!.season.pitching_stats!.WAR))
        }
        VStack {
            Text("Win")
            Text(String(viewModel.selectedPlayer!.stats!.season.pitching_stats!.win))
        }
        VStack {
            Text("Loss")
            Text(String(viewModel.selectedPlayer!.stats!.season.pitching_stats!.loss))
        }
        VStack {
            Text("ERA")
            Text(String(format: "%.2f", viewModel.selectedPlayer!.stats!.season.pitching_stats!.ERA))
        }
    }
    
    @ViewBuilder private func secondSection() -> some View {
        VStack {
            Text("Games")
            Text(String(viewModel.selectedPlayer!.stats!.season.pitching_stats!.games_pitched))
        }
        VStack {
            Text("Games Started")
            Text(String(viewModel.selectedPlayer!.stats!.season.pitching_stats!.games_started))
        }
        VStack {
            Text("Saves")
            Text(String(viewModel.selectedPlayer!.stats!.season.pitching_stats!.saves))
        }
    }
    
    @ViewBuilder private func thirdSection() -> some View {
        VStack {
            Text("Innings Pitched")
            Text(String(format: "%.1f", viewModel.selectedPlayer!.stats!.season.pitching_stats!.ERA))
        }
        VStack {
            Text("Strikeouts")
            Text(String(viewModel.selectedPlayer!.stats!.season.pitching_stats!.strikeouts))
        }
        VStack {
            Text("WHIP")
            Text(String(format: "%.2f", viewModel.selectedPlayer!.stats!.season.pitching_stats!.ERA))
        }
    }
}

//struct PitcherStatSummaryView_Previews: PreviewProvider {
//    static var previews: some View {
//        PitcherStatSummaryView()
//    }
//}
