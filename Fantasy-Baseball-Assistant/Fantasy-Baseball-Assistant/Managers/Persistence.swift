//
//  Persistence.swift
//  TestProject
//
//  Created by Eryk Lorenz on 4/9/23.
//

import CoreData

/// Handles all interactions with core data
class PersistenceController: ObservableObject {
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "FantasyBaseballAssistant")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    /// Handles saving core data
    ///
    /// If an error is thrown when trying to save then the error is printed to console and the application continues
    func saveData() {
        do {
            try container.viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    /// Gets the entity description
    ///
    /// - Parameters:
    ///    - entityName: String of the entity name
    ///
    /// - Returns: The entity description or nil
    func getDescription(entityName: String) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: entityName, in: container.viewContext)
    }
    
    /// Deletes a player from core data
    ///
    /// - Parameters:
    ///   - id: The UUID of the player to delete
    /// - Returns: Boolean of success of delete operations
    func deletePlayerByID(_ id: UUID) -> Bool {
        let fetchRequest: NSFetchRequest<Player> = Player.fetchRequest()
        fetchRequest.predicate = NSPredicate (
            format: "id == %@", id as CVarArg
        )
        
        do {
            let playerToDelete = try container.viewContext.fetch(fetchRequest) as [NSManagedObject]
            
            guard playerToDelete.count == 1 else {
                print("Did not find one player. Failed to delete")
                return false
            }
            
            container.viewContext.delete(playerToDelete.first!)
            saveData()
            return true
        } catch {
            return false
        }
    }
    
    /// Loads all players from core data
    ///
    /// - Returns: All players saved in core data or an empty array if no players exist
    func loadPlayers() -> [Player] {
        let fetchRequest: NSFetchRequest<Player> = Player.fetchRequest()
        do {
            return try container.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    /// Loads all matchups for a given date
    ///
    /// - Parameters:
    ///     - date: The date for which the matchups are being requested for
    ///
    /// - Returns: An array of the matchups or an emtpty array if none exist
    func loadMatchupsForDate(_ date: Date) -> [Matchup] {
        let fetchRequest: NSFetchRequest<Matchup> = Matchup.fetchRequest()
        let (startDate, endDate) = getStartEndDate(date)
        
        fetchRequest.predicate = NSPredicate (
            format: "date >= %@ AND date <= %@", startDate as NSDate, endDate as NSDate
        )
        fetchRequest.predicate = NSPredicate (
            format: "date >= %@ AND date <= %@", startDate as NSDate, endDate as NSDate
        )
        do {
            return try container.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    /// Deletes all matchups for a given date
    ///
    /// - Parameters:
    ///     - date: The date to delete all matchups for
    func deleteMatchupsForDate(_ date: Date) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Matchup.fetchRequest()
        let (startDate, endDate) = getStartEndDate(date)
        fetchRequest.predicate = NSPredicate (
            format: "date >= %@ AND date <= %@", startDate as NSDate, endDate as NSDate
        )
        
        do {
            let deleteRequest = NSBatchDeleteRequest (
                fetchRequest: fetchRequest
            )
            
            try container.viewContext.execute(deleteRequest)
            saveData()
        } catch {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "M/d/yyyy"
            print("Failed to delete matchup data for date: \(dateFormatter.string(from: date))")
        }
    }
    
    private func getStartEndDate(_ date: Date) -> (Date, Date) {
        let startDate = Calendar.current.startOfDay(for: date)
        var components = DateComponents()
        components.day = 1
        components.second = -1
        let endDate =  Calendar.current.date(byAdding: components, to: startDate) ?? startDate
        
        return (startDate, endDate)
    }
}
