//
//  Persistence.swift
//  TestProject
//
//  Created by Eryk Lorenz on 4/9/23.
//

import CoreData

struct PersistenceController {
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
}
