//
//  CenterView.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 3/31/23.
//

import SwiftUI

struct CenterView: View {
    var body: some View {
        VStack {
            PlayerSummaryView()
                .frame(maxHeight: 150)
            Divider()
            HStack {
                Button("Season") {}
                Button("Month") {}
                Button("Week") {}
                Button("Splits") {}
                Button("Game Log") {}
            }
            Divider()
            TestStatView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }.toolbar {
            ToolbarItem(placement: .navigation) {
                Button(action: backButton, label: {
                    Image(systemName: "chevron.backward")
                })
            }
        }
    }
}

private func backButton() {
    
}

struct CenterView_Previews: PreviewProvider {
    static var previews: some View {
        CenterView()
    }
}
