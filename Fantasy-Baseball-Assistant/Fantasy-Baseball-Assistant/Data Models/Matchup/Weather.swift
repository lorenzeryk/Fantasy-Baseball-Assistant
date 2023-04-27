//
//  Weather.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 4/23/23.
//

import Foundation
import CoreData


/// Stores weather condition and temperature for a matchup
@objc(WeatherInfo)
class WeatherInfo: NSManagedObject {
    @NSManaged var condition: String
    @NSManaged var temp: Int16
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherInfo> {
        return NSFetchRequest<WeatherInfo>(entityName: "WeatherInfo")
    }
    
    @objc
    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    init(condition: String?, temp: Int?, entity: NSEntityDescription, context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
        self.condition = condition ?? ""
        self.temp = Int16(temp ?? 0)
    }
}
