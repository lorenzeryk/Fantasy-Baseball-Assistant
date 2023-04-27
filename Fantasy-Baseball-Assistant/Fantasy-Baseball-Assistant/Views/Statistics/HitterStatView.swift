//
//  HitterStatView.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 4/14/23.
//

import SwiftUI

/// View that displays a table of statistics for hitters
struct HitterStatView: View {
    @ObservedObject var stats: StatViewModel
    @Binding var sortOrder: [KeyPathComparator<FielderStatsBase>]
    
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
        Table(stats.selectedHittingStats, sortOrder: $sortOrder) {
            TableColumn(stats.getKey(), value: \.key) { stat in
                Text(stats.translateKey(stat: stat))
            }
            TableColumn("Average", value: \.batting_average) { stat in
                Text(String(format: "%0.3f", stat.batting_average))
            }
            TableColumn("Hits", value: \.hits) { stat in
                Text("\(stat.hits)")
            }
            TableColumn("Homeruns", value: \.homeruns) { stat in
                Text("\(stat.homeruns)")
            }
            TableColumn("Runs", value: \.runs) { stat in
                Text("\(stat.runs)")
            }
            TableColumn("RBI", value: \.rbi) { stat in
                Text("\(stat.rbi)")
            }
            TableColumn("K", value: \.strike_outs) { stat in
                Text("\(stat.strike_outs)")
            }
            TableColumn("SB", value: \.stolen_bases) { stat in
                Text("\(stat.stolen_bases)")
            }
            TableColumn("CS", value: \.caught_stealing) { stat in
                Text("\(stat.caught_stealing)")
            }
        }
    }
    
    @ViewBuilder
    private func advancedStatView() -> some View {
        Table(stats.selectedHittingStats, sortOrder: $sortOrder) {
            TableColumn(stats.getKey(), value: \.key) { stat in
                Text(stats.translateKey(stat: stat))
            }
            TableColumn("Singles", value: \.single) { stat in
                Text("\(stat.single)")
            }
            TableColumn("Doubles", value: \.double) { stat in
                Text("\(stat.double)")
            }
            TableColumn("Triples", value: \.triple) { stat in
                Text("\(stat.triple)")
            }
            TableColumn("Walks", value: \.walks) { stat in
                Text("\(stat.walks)")
            }
            TableColumn("Intentional Walks", value: \.intentional_walks) { stat in
                Text("\(stat.intentional_walks)")
            }
            TableColumn("HBP", value: \.hit_by_pitch) { stat in
                Text("\(stat.hit_by_pitch)")
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
        }
    }
    
    @ViewBuilder
    private func basicStatViewSeason() -> some View {
        Table(stats.selectedHittingStats) {
            TableColumn("Average") { stat in
                Text(String(format: "%0.3f", stat.batting_average))
            }
            TableColumn("Hits") { stat in
                Text("\(stat.hits)")
            }
            TableColumn("Homeruns") { stat in
                Text("\(stat.homeruns)")
            }
            TableColumn("Runs") { stat in
                Text("\(stat.runs)")
            }
            TableColumn("RBI") { stat in
                Text("\(stat.rbi)")
            }
            TableColumn("K") { stat in
                Text("\(stat.strike_outs)")
            }
            TableColumn("SB") { stat in
                Text("\(stat.stolen_bases)")
            }
            TableColumn("CS") { stat in
                Text("\(stat.caught_stealing)")
            }
        }
    }
    
    @ViewBuilder
    private func advancedStatViewSeason() -> some View {
        Table(stats.selectedHittingStats) {
            TableColumn("Singles") { stat in
                Text("\(stat.single)")
            }
            TableColumn("Doubles") { stat in
                Text("\(stat.double)")
            }
            TableColumn("Triples") { stat in
                Text("\(stat.triple)")
            }
            TableColumn("Walks") { stat in
                Text("\(stat.walks)")
            }
            TableColumn("Intentional Walks") { stat in
                Text("\(stat.intentional_walks)")
            }
            TableColumn("HBP") { stat in
                Text("\(stat.hit_by_pitch)")
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
        }
    }
}

//struct HitterStatView_Previews: PreviewProvider {
//    static var previews: some View {
//        HitterStatView()
//    }
//}
