//
//  Player.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 3/30/23.
//

import Foundation
import CoreData

@objc(Player)
class Player: NSManagedObject, Identifiable {
    @NSManaged var id: UUID
    @NSManaged var first_name: String
    @NSManaged var last_name: String
    @NSManaged var primary_position_raw: Int16
    @NSManaged var team_raw: Int16
    
    var positions: [PlayerPosition] = []
    var stats: Stats?
    
    var primary_position: PlayerPosition {
        get {return PlayerPosition(rawValue: primary_position_raw) ?? PlayerPosition.None}
        set {self.primary_position_raw = newValue.rawValue}
    }
    var team: Team {
        get {return Team(rawValue: team_raw) ?? Team.None}
        set {self.team_raw = newValue.rawValue}
    }
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Player> {
        return NSFetchRequest<Player>(entityName: "Player")
    }
    
    @objc
    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    init(first_name: String, last_name: String, team: Team, primary_position: PlayerPosition, entity: NSEntityDescription, context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
        self.first_name = first_name
        self.last_name = last_name
        self.team_raw = team.rawValue
        self.primary_position_raw = primary_position.rawValue
        self.id = UUID()
    }
    
    func isPitcher() -> Bool {
        if (self.primary_position == PlayerPosition.SP || self.primary_position == PlayerPosition.RP) {
            return true
        } else {
            return false
        }
    }
    
    static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.id == rhs.id
    }
}
