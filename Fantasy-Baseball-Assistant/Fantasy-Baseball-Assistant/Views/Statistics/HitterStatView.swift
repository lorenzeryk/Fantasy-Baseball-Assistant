//
//  HitterStatView.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 4/14/23.
//

import SwiftUI

struct HitterStatView: View {
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
        Table(stats.selectedHittingStats) {
            TableColumn(stats.getKey()) { stat in
                Text(stats.translateKey(stat: stat))
            }
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
    private func advancedStatView() -> some View {
        Table(stats.selectedHittingStats) {
            TableColumn(stats.getKey()) { stat in
                Text(stats.translateKey(stat: stat))
            }
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
