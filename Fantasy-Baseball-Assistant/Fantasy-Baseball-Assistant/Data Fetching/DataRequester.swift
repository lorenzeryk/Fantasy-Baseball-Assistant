//
//  DataRequester.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 4/5/23.
//

import Foundation

struct DataRequester {
    let base_url = "https://api.sportradar.com/mlb/trial/v7/en"
    
    //TODO: move to secure environment variable
    var api_key: String = ""
    
    init() {
        api_key = retrieveAPIKey()
    }
    
    func getTeamProfile(team: Team) {
        let full_url = base_url + "/teams/" + team.teamID + "/profile.json?api_key=" + api_key
        
        guard let url = URL(string: full_url) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        print("sending request")
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error in request")
            }
            
            if let data = data {
                print("JSON String: \(String(data: data, encoding: .utf8))")
            }
        }
        
        task.resume()
    }
    
private func retrieveAPIKey() -> String {
    let keychainItem = [
        kSecClass: kSecClassGenericPassword,
        kSecAttrAccount: "FantasyBaseballAPIKey",
        kSecAttrService: "FantasyBaseballAPIKey",
        kSecReturnData: true
    ] as [CFString : Any] as CFDictionary

    var ref: AnyObject?
    
    //TODO: handle error
    guard SecItemCopyMatching(keychainItem, &ref) == 0 else {
        print("Failed to retrieve api key")
        return ""
    }
    
    guard let key_data = ref as? Data else {
        print("Failed to get data")
        return ""
    }
    
    guard let key = String(data: key_data, encoding: .utf8) else {
        print("Failed to convert key to string")
        return ""
    }
    
    return key
    }
}
