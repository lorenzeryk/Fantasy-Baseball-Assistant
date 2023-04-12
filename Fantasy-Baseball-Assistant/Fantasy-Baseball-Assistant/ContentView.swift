//
//  ContentView.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 3/30/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var mainViewModel = MainViewModel()
    @StateObject var stateManager: StateManager = StateManager()
    
    var body: some View {
        topLevelView(viewModel: mainViewModel, stateManager: stateManager)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
