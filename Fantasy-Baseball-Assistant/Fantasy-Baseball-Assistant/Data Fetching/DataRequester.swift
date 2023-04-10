//
//  DataRequester.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 4/5/23.
//

import Foundation

struct DataRequester {
    let base_url = "https://api.sportradar.com/mlb/trial/v7/en"

    var api_key: String = ""
    
    init() {
        api_key = retrieveAPIKey()
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
    
    func validatePlayer(first_name: String, last_name: String, team: Team) async -> Bool {
        let returnedPlayers: ReturnedTeamProfile? = await getTeamProfilePlayers(team: team)
        
        guard let players = returnedPlayers?.players else {
            print("No players returned in team profile")
            return false
        }
        
        return getPlayer(first_name: first_name, last_name: last_name, players: players)
    }
    
    private func getPlayer(first_name: String, last_name: String, players: [RequestedPlayer]) -> Bool {
        guard players.count != 0 else {
            print("No players in array of players")
            return false
        }
        
        for player in players {
            if (player.first_name == first_name && player.last_name == last_name) {
                print("Player found")
                return true
            }
        }
        print("Player not found")
        return false
    }
    
    private func getTeamProfilePlayers(team: Team, _ completion: @escaping (_ data: ReturnedTeamProfile?) -> Void) {
        let full_url = base_url + "/teams/" + team.teamID + "/profile.json?api_key=" + api_key
        
        guard let url = URL(string: full_url) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error requesting team profile for \(team): \(error)")
                completion(nil)
            }

            if let data = data {
                //TODO: cite from https://benscheirman.com/2017/06/swift-json.html
                if let players = try? JSONDecoder().decode(ReturnedTeamProfile.self, from: data) {
                    completion(players)
                    return
                }
                completion(nil)
            }
        }.resume()
    }
    
    private func getTeamProfilePlayers(team: Team) async -> ReturnedTeamProfile? {
        //TODO: cite from https://www.hackingwithswift.com/quick-start/concurrency/how-to-use-continuations-to-convert-completion-handlers-into-async-functions
        await withCheckedContinuation { continuation in
            getTeamProfilePlayers(team: team) { players in
                continuation.resume(returning: players)
            }
        }
    }
}
