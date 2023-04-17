//
//  TestStatView.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 3/31/23.
//

import SwiftUI

struct MainStatView: View {
    @EnvironmentObject var stateManager: StateManager
    @ObservedObject var statViewModel: StatViewModel
    
    var body: some View {
        HStack {
            Spacer()
            HStack {
                Button("Season") {
                    updateStatView(view: SelectedStatView.Season)
                }
                Button("Month") {
                    updateStatView(view: SelectedStatView.Month)
                }
                Button("Day/Night") {
                    updateStatView(view: SelectedStatView.DayNight)
                }
                Button("By Opponent") {
                    updateStatView(view: SelectedStatView.Opponent)
                }
            }
            Spacer()
            Toggle("Detailed", isOn: $statViewModel.displayAdvancedStats)
                .toggleStyle(.switch)
        }
        Divider()
        if (stateManager.selectedPlayer != nil && stateManager.selectedPlayer!.isPitcher()) {
            PitcherStatView(stats: statViewModel)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
            HitterStatView(stats: statViewModel)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    private func updateStatView(view: SelectedStatView) {
        statViewModel.selectedStatView = view
    }
}

//struct MainStatView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainStatView()
//    }
//}
