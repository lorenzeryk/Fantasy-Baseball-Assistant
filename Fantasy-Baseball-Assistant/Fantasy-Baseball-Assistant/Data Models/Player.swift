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
    @NSManaged var api_id: String
    @NSManaged var primary_position_raw: Int16
    @NSManaged var team_raw: Int16
    @NSManaged var secondary_positions_raw: [Int]
    @NSManaged var last_stat_update: Date
    @NSManaged var hittingStats: FielderStats?
    @NSManaged var pitchingStats: PitcherStats?
    
    var positions: [PlayerPosition] = []
    
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

    init(first_name: String, last_name: String, api_id: String,team: Team, primary_position: PlayerPosition, secondary_positions: [PlayerPosition]?, entity: NSEntityDescription, context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
        self.first_name = first_name
        self.last_name = last_name
        self.api_id = api_id
        self.team_raw = team.rawValue
        self.primary_position_raw = primary_position.rawValue
        self.secondary_positions_raw = []
        self.id = UUID()
        self.last_stat_update = Date(timeIntervalSinceReferenceDate: 0) //initialize date to time 0
        if (secondary_positions != nil) {
            self.positions = secondary_positions!
        } else {
            self.positions = []
        }
        updateRawSecondaryPositions()
    }
    
    func isPitcher() -> Bool {
        if (self.primary_position == PlayerPosition.SP || self.primary_position == PlayerPosition.RP) {
            return true
        } else {
            return false
        }
    }
    
    func updateRawSecondaryPositions() {
        secondary_positions_raw = []
        for position in positions {
            secondary_positions_raw.append(Int(position.rawValue))
        }
    }
    
    func setSecondaryPositions() {
        positions = []
        for rawPosition in secondary_positions_raw {
            positions.append(PlayerPosition(rawValue: Int16(rawPosition))!)
        }
    }
    
    static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.id == rhs.id
    }
}
