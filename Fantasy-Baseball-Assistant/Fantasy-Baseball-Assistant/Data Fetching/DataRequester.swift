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
    let num_retries = 5
    let min_sleep_retry = 1
    let max_sleep_retry = 5
    @AppStorage("api_key") var api_key: String = ""
}

extension DataRequester {
    enum responseError: Error {
        case overQPS
    }
}
