//
//  ContentView.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 3/30/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var mainViewModel = MainViewModel()
    var tempPlayers: [Player] = []
    
    var body: some View {
        topLevelView(viewModel: mainViewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
