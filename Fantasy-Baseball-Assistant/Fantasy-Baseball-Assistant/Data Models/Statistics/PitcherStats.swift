//
//  PitcherStats.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 4/14/23.
//

import Foundation
import CoreData

@objc(PitcherStats)
class PitcherStats: NSManagedObject {
    @NSManaged var season: PitcherStatsBase
    @NSManaged var month: Set<PitcherStatsBase>
    @NSManaged var day_night: Set<PitcherStatsBase>
    @NSManaged var home_away: Set<PitcherStatsBase>
    @NSManaged var byOpponent: Set<PitcherStatsBase>
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<PitcherStats> {
        return NSFetchRequest<PitcherStats>(entityName: "PitcherStats")
    }
    
    @objc
    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    init(entity: NSEntityDescription, baseStatEntity: NSEntityDescription, context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
        season = PitcherStatsBase(entity: baseStatEntity, context: context)
        month = Set<PitcherStatsBase>()
        day_night = Set<PitcherStatsBase>()
        byOpponent = Set<PitcherStatsBase>()
        home_away = Set<PitcherStatsBase>()
    }
}
