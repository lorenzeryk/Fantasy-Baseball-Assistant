//
//  PitcherStats.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 3/30/23.
//

import Foundation
import CoreData

/// Base class for pitcher statistics
@objc(PitcherStatsBase)
class PitcherStatsBase: NSManagedObject, Identifiable {
    @NSManaged var win: Int16
    @NSManaged var loss: Int16
    /// Innings pitched
    @NSManaged var ip_2: Double
    /// Hits
    @NSManaged var h: Int16
    /// Earned Run Average
    @NSManaged var era: Double
    /// Total Strikeouts
    @NSManaged var ktotal: Int16
    /// Walks
    @NSManaged var bb: Int16
    
    @NSManaged var hr: Int16
    /// Opponent Batting Average
    @NSManaged var oba: Double
    /// Opponent On Base Percentage
    @NSManaged var obp: Double
    /// Opponent Slugging Percentage
    @NSManaged var slg: Double
    /// Opponent On Base Plus Slugging
    @NSManaged var ops: Double
    @NSManaged var save: Int16
    /// Save Opportunities
    @NSManaged var svo: Int16
    
    @NSManaged var key: String
    @NSManaged var play: Int16
    
    var whip: Double {
        Double(bb + h) / ip_2
    }
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<PitcherStatsBase> {
        return NSFetchRequest<PitcherStatsBase>(entityName: "PitcherStatsBase")
    }
    
    @objc
    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    
    init(win: Int?, loss: Int?, ip_2: Double?, h: Int?, era: Double?, ktotal: Int?, bb: Int?, hr: Int?, oba: Double?, obp: Double?, slg: Double?, ops: Double?, save: Int?, svo: Int?, key: String = "", play: Int?, entity: NSEntityDescription, context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
        self.win = Int16(win ?? 0)
        self.loss = Int16(loss ?? 0)
        self.save = Int16(save ?? 0)
        self.svo = Int16(svo ?? 0)
        self.play = Int16(play ?? 0)
        self.ip_2 = ip_2 ?? 0.0
        self.h = Int16(h ?? 0)
        self.hr = Int16(hr ?? 0)
        self.bb = Int16(bb ?? 0)
        self.oba = oba ?? 0.0
        self.era = era ?? 0.0
        self.ktotal = Int16(ktotal ?? 0)
        self.obp = obp ?? 0.0
        self.slg = slg ?? 0.0
        self.ops = ops ?? 0.0
        self.key = key
    }
    
    init(entity: NSEntityDescription, context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
        self.win = 0
        self.loss = 0
        self.save = 0
        self.svo = 0
        self.play = 0
        self.ip_2 = 0
        self.h = 0
        self.hr = 0
        self.bb = 0
        self.oba = 0
        self.era = 0
        self.ktotal = 0
        self.obp = 0
        self.slg = 0
        self.ops = 0
        self.key = ""
    }
}
