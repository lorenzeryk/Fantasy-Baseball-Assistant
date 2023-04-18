//
//  Fantasy_Baseball_AssistantApp.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 3/30/23.
//

import SwiftUI

@main
struct Fantasy_Baseball_AssistantApp: App {
    @StateObject var stateManager: StateManager = StateManager()
    @StateObject var dataRequester: DataRequester = DataRequester()
    @StateObject var persistenceController: PersistenceController = PersistenceController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(stateManager)
                .environmentObject(dataRequester)
                .environmentObject(persistenceController)
        }
        Settings {
            Preferences()
                .environmentObject(dataRequester)
        }
    }
}
