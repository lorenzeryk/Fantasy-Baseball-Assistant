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
        Table(stats.selectedHittingStats) {
            TableColumn("Test") { stat in
                Text(stat.key ?? "")
            }
            TableColumn("Average") { stat in
                Text(String(format: "%0.3f", stat.batting_average))
            }
            TableColumn("AB") { stat in
                Text("\(stat.ab)")
            }
            TableColumn("Hits") { stat in
                Text("\(stat.hits)")
            }
            TableColumn("HR") { stat in
                Text("\(stat.homeruns)")
            }
            TableColumn("Runs") { stat in
                Text("\(stat.runs)")
            }
            TableColumn("RBI") { stat in
                Text("\(stat.rbi)")
            }
            TableColumn("SB") { stat in
                Text("\(stat.stolen_bases)")
            }
            TableColumn("OBP") { stat in
                Text(String(format: "%0.3f", stat.obp))
            }
            TableColumn("SLG") { stat in
                Text(String(format: "%0.3f", stat.slg))
            }
//            TableColumn("OPS") { stat in
//                Text(String(format: "%0.3f", stat.ops))
//            }
        }
    }
}

//struct HitterStatView_Previews: PreviewProvider {
//    static var previews: some View {
//        HitterStatView()
//    }
//}
