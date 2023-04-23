//
//  Matchup.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 4/23/23.
//

import Foundation
import CoreData

@objc(Matchup)
class Matchup: NSManagedObject {
    @NSManaged var date: Date
    @NSManaged var home_team_raw: Int16
    @NSManaged var away_team_raw: Int16
    @NSManaged var weather: WeatherInfo
    @NSManaged var home_team_info: TeamMatchupData
    @NSManaged var away_team_info: TeamMatchupData
    
    var home_team: Team {
        Team(rawValue: home_team_raw) ?? Team.None
    }
    
    var away_team: Team {
        Team(rawValue: away_team_raw) ?? Team.None
    }
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Matchup> {
        return NSFetchRequest<Matchup>(entityName: "Matchup")
    }
    
    @objc
    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    init(date: Date, home_team: String, away_team: String, weather: WeatherInfo, home_team_info: TeamMatchupData, away_team_info: TeamMatchupData, entity: NSEntityDescription, context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
        self.date = date
        self.home_team_raw = Team.None.getTeamFromID(home_team).rawValue
        self.away_team_raw = Team.None.getTeamFromID(away_team).rawValue
        self.weather = weather
        self.home_team_info = home_team_info
        self.away_team_info = away_team_info
    }
}
