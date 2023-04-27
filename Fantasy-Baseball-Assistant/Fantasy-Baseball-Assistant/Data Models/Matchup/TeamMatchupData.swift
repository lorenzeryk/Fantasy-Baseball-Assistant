//
//  TeamMatchupData.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 4/23/23.
//

import Foundation
import CoreData

/// Stores the starting players and record of a single team in a matchup
@objc(TeamMatchupData)
class TeamMatchupData: NSManagedObject {
    @NSManaged var id: String
    @NSManaged var win: Int16
    @NSManaged var loss: Int16
    @NSManaged var startingPlayers: [String]
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<TeamMatchupData> {
        return NSFetchRequest<TeamMatchupData>(entityName: "TeamMatchupData")
    }
    
    @objc
    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    init(id: String?, win: Int?, loss: Int?, startingPlayers: [PlayerID]?, entity: NSEntityDescription, context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
        self.id = id ?? ""
        self.win = Int16(win ?? 0)
        self.loss = Int16(loss ?? 0)
        self.startingPlayers = []
        createStartingPlayers(startingPlayers)
    }
    
    private func createStartingPlayers(_ players: [PlayerID]?) {
        guard players != nil else {
            return
        }
        
        for player in players! {
            self.startingPlayers.append(player.id ?? "")
        }
    }
}
