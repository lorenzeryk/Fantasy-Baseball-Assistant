//
//  PitcherStatView.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 4/14/23.
//

import SwiftUI

struct PitcherStatView: View {
    @ObservedObject var stats: StatViewModel
    
    var body: some View {
        if (stats.displayAdvancedStats) {
            if (stats.selectedStatView == SelectedStatView.Season) {
                advancedStatViewSeason()
            } else {
                advancedStatView()
            }
        } else {
            if (stats.selectedStatView == SelectedStatView.Season) {
                basicStatViewSeason()
            } else {
                basicStatView()
            }
        }
    }
    
    @ViewBuilder
    private func basicStatView() -> some View {
        Table(stats.selectedPitchingStats) {
            TableColumn(stats.getKey()) { stat in
                Text(stats.translateKey(stat: stat))
            }
            TableColumn("Win") { stat in
                Text("\(stat.win)")
            }
            TableColumn("Loss") { stat in
                Text("\(stat.loss)")
            }
            TableColumn("Innings Pitched") { stat in
                Text(String(format: "%0.1f", stat.ip_2))
            }
            TableColumn("Hits") { stat in
                Text("\(stat.h)")
            }
            TableColumn("ERA") { stat in
                Text(String(format: "%0.2f", stat.era))
            }
            TableColumn("K") { stat in
                Text("\(stat.ktotal)")
            }
            TableColumn("BB") { stat in
                Text("\(stat.bb)")
            }
        }
    }
    
    @ViewBuilder
    func basicStatViewSeason() -> some View {
        Table(stats.selectedPitchingStats) {
            TableColumn("Win") { stat in
                Text("\(stat.win)")
            }
            TableColumn("Loss") { stat in
                Text("\(stat.loss)")
            }
            TableColumn("Innings Pitched") { stat in
                Text(String(format: "%0.1f", stat.ip_2))
            }
            TableColumn("Hits") { stat in
                Text("\(stat.h)")
            }
            TableColumn("ERA") { stat in
                Text(String(format: "%0.2f", stat.era))
            }
            TableColumn("K") { stat in
                Text("\(stat.ktotal)")
            }
            TableColumn("BB") { stat in
                Text("\(stat.bb)")
            }
        }
    }
    
    @ViewBuilder
    func advancedStatView() -> some View {
        Table(stats.selectedPitchingStats) {
            TableColumn(stats.getKey()) { stat in
                Text(stats.translateKey(stat: stat))
            }
            TableColumn("HR") { stat in
                Text("\(stat.hr)")
            }
            TableColumn("OBA") { stat in
                Text(String(format: "%0.3f", stat.oba))
            }
            TableColumn("OBP") { stat in
                Text(String(format: "%0.3f", stat.obp))
            }
            TableColumn("SLG") { stat in
                Text(String(format: "%0.3f", stat.slg))
            }
            TableColumn("OPS") { stat in
                Text(String(format: "%0.3f", stat.ops))
            }
            TableColumn("Saves") { stat in
                Text("\(stat.save)")
            }
            TableColumn("Save Opportunities") { stat in
                Text("\(stat.svo)")
            }
        }
    }
    
    @ViewBuilder
    func advancedStatViewSeason() -> some View {
        Table(stats.selectedPitchingStats) {
            TableColumn("HR") { stat in
                Text("\(stat.hr)")
            }
            TableColumn("OBA") { stat in
                Text(String(format: "%0.3f", stat.oba))
            }
            TableColumn("OBP") { stat in
                Text(String(format: "%0.3f", stat.obp))
            }
            TableColumn("SLG") { stat in
                Text(String(format: "%0.3f", stat.slg))
            }
            TableColumn("OPS") { stat in
                Text(String(format: "%0.3f", stat.ops))
            }
            TableColumn("Saves") { stat in
                Text("\(stat.save)")
            }
            TableColumn("Save Opportunities") { stat in
                Text("\(stat.svo)")
            }
        }
    }
}

//struct PitcherStatView_Previews: PreviewProvider {
//    static var previews: some View {
//        PitcherStatView()
//    }
//}
