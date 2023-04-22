//
//  DataRequester.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 4/5/23.
//

import Foundation
import SwiftUI

class DataRequester: ObservableObject {
    let base_url = "https://api.sportradar.com/mlb/trial/v7/en"

    @AppStorage("api_key") var api_key: String = ""
}
