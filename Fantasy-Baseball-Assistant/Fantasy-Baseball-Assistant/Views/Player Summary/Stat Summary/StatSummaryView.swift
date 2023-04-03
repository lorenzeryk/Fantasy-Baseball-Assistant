//
//  StatSummaryView.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 3/31/23.
//

import SwiftUI

struct StatSummaryView: View {
    var body: some View {
        VStack {
            Text("Season Stat Summary")
                .font(.system(size: 32))
            HitterStatSummaryView()
        }
    }
}

struct StatSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        StatSummaryView()
    }
}
