//
//  Persistence.swift
//  TestProject
//
//  Created by Eryk Lorenz on 4/9/23.
//

import CoreData

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
    
    func saveData() {
        do {
            try container.viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func getDescription(entityName: String) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: entityName, in: container.viewContext)
    }
    
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
    
    func loadPlayers() -> [Player] {
        let fetchRequest: NSFetchRequest<Player> = Player.fetchRequest()
        do {
            return try container.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
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
