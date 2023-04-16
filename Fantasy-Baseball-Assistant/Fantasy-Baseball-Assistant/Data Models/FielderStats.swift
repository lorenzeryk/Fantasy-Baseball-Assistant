//
//  FielderStats.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 4/14/23.
//

import Foundation
import CoreData

@objc(FielderStats)
class FielderStats: NSManagedObject {
    @NSManaged var season: FielderStatsBase
    @NSManaged var month: Set<FielderStatsBase>
    @NSManaged var day_night: Set<FielderStatsBase>
    @NSManaged var byOpponent: Set<FielderStatsBase>
    @NSManaged var home_away: Set<FielderStatsBase>
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<FielderStats> {
        return NSFetchRequest<FielderStats>(entityName: "FielderStats")
    }
    
    init(entity: NSEntityDescription, baseStatEntity: NSEntityDescription, context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
        season = FielderStatsBase(entity: baseStatEntity, context: context)
        month = Set<FielderStatsBase>()
        day_night = Set<FielderStatsBase>()
        byOpponent = Set<FielderStatsBase>()
        home_away = Set<FielderStatsBase>()
    }
    
    @objc
    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
}
