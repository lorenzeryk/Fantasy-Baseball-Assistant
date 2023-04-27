//
//  MatchupView.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 3/31/23.
//

import SwiftUI

/// View that displays a player's game information for the current day
struct MatchupView: View {
    @ObservedObject var viewModel: MatchupViewModel
    
    var body: some View {
        VStack {
            Text("Today's Game")
                .font(.system(size: 32))
            if (viewModel.currentMatchup == nil) {
                Text("No game")
            } else {
                matchupData()
            }
        }
        .padding()
    }
    
    @ViewBuilder
    func matchupData() -> some View {
        Text("Player Status: \(viewModel.playerStatus)")
            .font(.system(size: 20))
        Text("Scheduled Start Time: \(viewModel.getStartTime())")
        Text("Weather: \(viewModel.currentMatchup!.weather.condition) \(viewModel.currentMatchup!.weather.temp)°F")
        HStack {
            VStack {
                Text(viewModel.currentMatchup!.away_team.fullText)
                Text("\(viewModel.currentMatchup!.away_team_info.win)-\(viewModel.currentMatchup!.away_team_info.loss)")
            }
            VStack {
                Text("@")
                Text("")
            }
            VStack {
                Text(viewModel.currentMatchup!.home_team.fullText)
                Text("\(viewModel.currentMatchup!.home_team_info.win)-\(viewModel.currentMatchup!.home_team_info.loss)")
            }
        }
    }
}

//struct MatchupView_Previews: PreviewProvider {
//    static var viewModel: MatchupViewModel = MatchupViewModel()
//
//    static var previews: some View {
//        MatchupView(viewModel: viewModel)
//    }
//}
