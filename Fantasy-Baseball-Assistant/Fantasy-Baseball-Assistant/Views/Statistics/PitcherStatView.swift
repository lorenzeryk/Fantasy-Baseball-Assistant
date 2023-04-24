//
//  PitcherStatView.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 4/14/23.
//

import SwiftUI

struct PitcherStatView: View {
    @ObservedObject var stats: StatViewModel
    @Binding var sortOrder: [KeyPathComparator<PitcherStatsBase>]

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
        Table(stats.selectedPitchingStats, sortOrder: $sortOrder) {
            TableColumn(stats.getKey(), value: \.key) { stat in
                Text(stats.translateKey(stat: stat))
            }
            TableColumn("Win", value: \.win) { stat in
                Text("\(stat.win)")
            }
            TableColumn("Loss", value: \.loss) { stat in
                Text("\(stat.loss)")
            }
            TableColumn("Innings Pitched", value: \.ip_2) { stat in
                Text(String(format: "%0.1f", stat.ip_2))
            }
            TableColumn("Hits", value: \.h) { stat in
                Text("\(stat.h)")
            }
            TableColumn("ERA", value: \.era) { stat in
                Text(String(format: "%0.2f", stat.era))
            }
            TableColumn("K", value: \.ktotal) { stat in
                Text("\(stat.ktotal)")
            }
            TableColumn("BB", value: \.bb) { stat in
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
        Table(stats.selectedPitchingStats, sortOrder: $sortOrder) {
            TableColumn(stats.getKey(), value: \.key) { stat in
                Text(stats.translateKey(stat: stat))
            }
            TableColumn("HR", value: \.hr) { stat in
                Text("\(stat.hr)")
            }
            TableColumn("OBA", value: \.oba) { stat in
                Text(String(format: "%0.3f", stat.oba))
            }
            TableColumn("OBP", value: \.obp) { stat in
                Text(String(format: "%0.3f", stat.obp))
            }
            TableColumn("SLG", value: \.slg) { stat in
                Text(String(format: "%0.3f", stat.slg))
            }
            TableColumn("OPS", value: \.ops) { stat in
                Text(String(format: "%0.3f", stat.ops))
            }
            TableColumn("Saves", value: \.save) { stat in
                Text("\(stat.save)")
            }
            TableColumn("Save Opportunities", value: \.svo) { stat in
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
