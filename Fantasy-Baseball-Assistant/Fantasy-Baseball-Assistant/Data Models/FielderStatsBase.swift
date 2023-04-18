//
//  FielderStats.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 3/30/23.
//

import Foundation
import CoreData

@objc(FielderStatsBase)
class FielderStatsBase: NSManagedObject, Identifiable {
    @NSManaged var batting_average: Double
    @NSManaged var ab: Int16
    @NSManaged var hits: Int16
    @NSManaged var homeruns: Int16
    @NSManaged var runs: Int16
    @NSManaged var rbi: Int16
    @NSManaged var strike_outs: Int16
    @NSManaged var stolen_bases: Int16
    @NSManaged var caught_stealing: Int16
    
    @NSManaged var single: Int16
    @NSManaged var double: Int16
    @NSManaged var triple: Int16
    @NSManaged var walks: Int16
    @NSManaged var intentional_walks: Int16
    @NSManaged var hit_by_pitch: Int16
    @NSManaged var obp: Double
    @NSManaged var slg: Double
    @NSManaged var ops: Double
    
    @NSManaged var key: String
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<FielderStatsBase> {
        return NSFetchRequest<FielderStatsBase>(entityName: "FielderStatsBase")
    }
    
    init(batting_average: Double, ab: Int, hits: Int, homeruns: Int, runs: Int, rbi: Int, stolen_bases: Int, obp: Double, slg: Double, ops: Double, single: Int, double: Int, triple: Int, walks: Int, intentional_walks: Int, hit_by_pitch: Int, caught_stealing: Int, strike_outs: Int, key: String = "", entity: NSEntityDescription, context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
        self.batting_average = batting_average
        self.ab = Int16(ab)
        self.hits = Int16(hits)
        self.homeruns = Int16(homeruns)
        self.runs = Int16(runs)
        self.rbi = Int16(rbi)
        self.stolen_bases = Int16(stolen_bases)
        self.obp = obp
        self.slg = slg
        self.ops = ops
        self.single = Int16(single)
        self.double = Int16(double)
        self.triple = Int16(triple)
        self.walks = Int16(walks)
        self.intentional_walks = Int16(intentional_walks)
        self.hit_by_pitch = Int16(hit_by_pitch)
        self.caught_stealing = Int16(caught_stealing)
        self.strike_outs = Int16(strike_outs)
        self.key = key
    }
    
    init(entity: NSEntityDescription, context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
        self.batting_average = 0.0
        self.ab = 0
        self.hits = 0
        self.homeruns = 0
        self.runs = 0
        self.rbi = 0
        self.stolen_bases = 0
        self.obp = 0.0
        self.slg = 0.0
        self.ops = 0.0
        self.single = 0
        self.double = 0
        self.triple = 0
        self.walks = 0
        self.intentional_walks = 0
        self.hit_by_pitch = 0
        self.caught_stealing = 0
        self.strike_outs = 0
        self.key = ""
    }
    
    @objc
    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
}