//
//  PitcherStatSummaryView.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 3/31/23.
//

import SwiftUI

struct PitcherStatSummaryView: View {
    var body: some View {
        HStack {
            firstSection()
            Divider()
            secondSection()
            Divider()
            thirdSection()
        }
    }
    
    //TODO: change func names
    @ViewBuilder private func firstSection() -> some View {
        VStack {
            Text("WAR")
            Text("0")
        }
        VStack {
            Text("Win")
            Text("0")
        }
        VStack {
            Text("Loss")
            Text("0")
        }
        VStack {
            Text("ERA")
            Text("0")
        }
    }
    
    @ViewBuilder private func secondSection() -> some View {
        VStack {
            Text("G")
            Text("0")
        }
        VStack {
            Text("GS")
            Text("0")
        }
        VStack {
            Text("SV")
            Text("0")
        }
    }
    
    @ViewBuilder private func thirdSection() -> some View {
        VStack {
            Text("IP")
            Text("0")
        }
        VStack {
            Text("SO")
            Text("0")
        }
        VStack {
            Text("WHIP")
            Text("0")
        }
    }
}

struct PitcherStatSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        PitcherStatSummaryView()
    }
}
