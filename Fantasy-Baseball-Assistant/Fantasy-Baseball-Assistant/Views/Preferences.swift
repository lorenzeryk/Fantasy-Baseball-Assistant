//
//  Preferences.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 4/17/23.
//

import SwiftUI

struct Preferences: View {
    @EnvironmentObject var dataRequester: DataRequester
    
    var body: some View {
        HStack {
            Text("API Key:")
            TextField("API Key", text: $dataRequester.api_key)
        }.padding()
    }
}

struct Preferences_Previews: PreviewProvider {
    static var previews: some View {
        Preferences()
    }
}
