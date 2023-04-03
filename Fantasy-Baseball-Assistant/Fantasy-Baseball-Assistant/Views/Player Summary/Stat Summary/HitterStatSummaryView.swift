//
//  HitterStatSummaryView.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 3/31/23.
//

import SwiftUI

struct HitterStatSummaryView: View {
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
            Text("AB")
            Text("0")
        }
        VStack {
            Text("H")
            Text("0")
        }
        VStack {
            Text("HR")
            Text("0")
        }
        VStack {
            Text("BA")
            Text("0")
        }
    }
    
    @ViewBuilder private func secondSection() -> some View {
        VStack {
            Text("R")
            Text("0")
        }
        VStack {
            Text("RBI")
            Text("0")
        }
        VStack {
            Text("SB")
            Text("0")
        }
    }
    
    @ViewBuilder private func thirdSection() -> some View {
        VStack {
            Text("OBP")
            Text("0")
        }
        VStack {
            Text("SLG")
            Text("0")
        }
        VStack {
            Text("OPS")
            Text("0")
        }
        VStack {
            Text("OPS+")
            Text("0")
        }
    }
}

struct HitterStatSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        HitterStatSummaryView()
    }
}
