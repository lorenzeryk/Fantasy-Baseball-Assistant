//
//  ContentView.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 3/30/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var stateManager: StateManager
    
    var body: some View {
        topLevelView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
