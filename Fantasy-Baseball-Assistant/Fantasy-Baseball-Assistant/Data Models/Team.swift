//
//  Team.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 3/30/23.
//

import Foundation

enum Team: Int16, CaseIterable {
    case None = 0
    case Diamondbacks = 1
    case Braves = 2
    case Orioles = 3
    case RedSox = 4
    case WhiteSox = 5
    case Cubs = 6
    case Reds = 7
    case Guardings = 8
    case Rockies = 9
    case Tigers = 10
    case Astros = 11
    case Royals = 12
    case Angels = 13
    case Dodgers = 14
    case Marlins = 15
    case Brewers = 16
    case Twins = 17
    case Yankees = 18
    case Mets = 19
    case Athletics = 20
    case Phillies = 21
    case Pirates = 22
    case Padres = 23
    case Giants = 24
    case Mariners = 25
    case Cardinals = 26
    case Rays = 27
    case Rangers = 28
    case BlueJays = 29
    case Nationals = 30
    
    var abbreviation: String {
        switch self {
        case .Diamondbacks: return "ARI"
        case .Braves: return "ATL"
        case .Orioles: return "BAL"
        case .RedSox: return "BOS"
        case .WhiteSox: return "CHW"
        case .Cubs: return "CHC"
        case .Reds: return "CIN"
        case .Guardings: return "CLE"
        case .Rockies: return "COL"
        case .Tigers: return "DET"
        case .Astros: return "HOU"
        case .Royals: return "KC"
        case .Angels: return "LAA"
        case .Dodgers: return "LAD"
        case .Marlins: return "MIA"
        case .Brewers: return "MIL"
        case .Twins: return "MIN"
        case .Yankees: return "NYY"
        case .Mets: return "NYM"
        case .Athletics: return "OAK"
        case .Phillies: return "PHI"
        case .Pirates: return "PIT"
        case .Padres: return "SD"
        case .Giants: return "SF"
        case .Mariners: return "SEA"
        case .Cardinals: return "STL"
        case .Rays: return "TB"
        case .Rangers: return "TEX"
        case .BlueJays: return "TOR"
        case .Nationals: return "WSH"
        case .None: return ""
        }
    }
    
    var fullText: String {
        switch self {
        case .Diamondbacks: return "Arizona Diamondbacks"
        case .Braves: return "Atlanta Braves"
        case .Orioles: return "Baltimore Orioles"
        case .RedSox: return "Boston Red Sox"
        case .WhiteSox: return "Chicago White Sox"
        case .Cubs: return "Chicago Cubs"
        case .Reds: return "Cincinatti Reds"
        case .Guardings: return "Cleveland Guardians"
        case .Rockies: return "Colorado Rockies"
        case .Tigers: return "Detroit Tigers"
        case .Astros: return "Houston Astros"
        case .Royals: return "Kansas City Royals"
        case .Angels: return "Los Angeles Angels"
        case .Dodgers: return "Los Angeles Dodgers"
        case .Marlins: return "Miami Marlins"
        case .Brewers: return "Milwaukee Brewers"
        case .Twins: return "Minnesota Twins"
        case .Yankees: return "New York Yankees"
        case .Mets: return "New York Mets"
        case .Athletics: return "Oakland Athletics"
        case .Phillies: return "Philadelphia Phillies"
        case .Pirates: return "Pittsburgh Pirates"
        case .Padres: return "San Diego Padres"
        case .Giants: return "San Fransisco Giants"
        case .Mariners: return "Seattle Mariners"
        case .Cardinals: return "St Louis Cardinals"
        case .Rays: return "Tampa Bay Rays"
        case .Rangers: return "Texas Rangers"
        case .BlueJays: return "Toronto Blue Jays"
        case .Nationals: return "Washington Nationals"
        case .None: return ""
        }
    }
    
    var teamID: String {
        switch self {
        case .Diamondbacks: return "25507be1-6a68-4267-bd82-e097d94b359b"
        case .Braves: return "12079497-e414-450a-8bf2-29f91de646bf"
        case .Orioles: return "75729d34-bca7-4a0f-b3df-6f26c6ad3719"
        case .RedSox: return "93941372-eb4c-4c40-aced-fe3267174393"
        case .WhiteSox: return "47f490cd-2f58-4ef7-9dfd-2ad6ba6c1ae8"
        case .Cubs: return "55714da8-fcaf-4574-8443-59bfb511a524"
        case .Reds: return "c874a065-c115-4e7d-b0f0-235584fb0e6f"
        case .Guardings: return "80715d0d-0d2a-450f-a970-1b9a3b18c7e7"
        case .Rockies: return "29dd9a87-5bcc-4774-80c3-7f50d985068b"
        case .Tigers: return "575c19b7-4052-41c2-9f0a-1c5813d02f99"
        case .Astros: return "eb21dadd-8f10-4095-8bf3-dfb3b779f107"
        case .Royals: return "833a51a9-0d84-410f-bd77-da08c3e5e26e"
        case .Angels: return "4f735188-37c8-473d-ae32-1f7e34ccf892"
        case .Dodgers: return "ef64da7f-cfaf-4300-87b0-9313386b977c"
        case .Marlins: return "03556285-bdbb-4576-a06d-42f71f46ddc5"
        case .Brewers: return "dcfd5266-00ce-442c-bc09-264cd20cf455"
        case .Twins: return "aa34e0ed-f342-4ec6-b774-c79b47b60e2d"
        case .Yankees: return "a09ec676-f887-43dc-bbb3-cf4bbaee9a18"
        case .Mets: return "f246a5e5-afdb-479c-9aaa-c68beeda7af6"
        case .Athletics: return "27a59d3b-ff7c-48ea-b016-4798f560f5e1"
        case .Phillies: return "2142e1ba-3b40-445c-b8bb-f1f8b1054220"
        case .Pirates: return "481dfe7e-5dab-46ab-a49f-9dcc2b6e2cfd"
        case .Padres: return "d52d5339-cbdd-43f3-9dfa-a42fd588b9a3"
        case .Giants: return "a7723160-10b7-4277-a309-d8dd95a8ae65"
        case .Mariners: return "43a39081-52b4-4f93-ad29-da7f329ea960"
        case .Cardinals: return "44671792-dc02-4fdd-a5ad-f5f17edaa9d7"
        case .Rays: return "bdc11650-6f74-49c4-875e-778aeb7632d9"
        case .Rangers: return "d99f919b-1534-4516-8e8a-9cd106c6d8cd"
        case .BlueJays: return "1d678440-b4b1-4954-9b39-70afb3ebbcfa"
        case .Nationals: return "d89bed32-3aee-4407-99e3-4103641b999a"
        case .None: return ""
        }
    }
}
