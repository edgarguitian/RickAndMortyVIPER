//
//  CoreDataManager.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 28/12/23.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    private init() {}
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CharacterDataModel")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - Character CRUD operations
    
    func insertCharacter(entity: CharactersEntity) {
        let context = persistentContainer.viewContext
        let character = Character(context: context)
        let characterAttributes = entity.toDictionary()
        character.setValuesForKeys(characterAttributes)
        
        saveContext()
    }
    
    func insertCharacters(entities: [CharactersEntity], page: Int, numPages: Int) {
        let context = persistentContainer.viewContext
        
        for entity in entities {
            let character = Character(context: context)
            let characterAttributes = entity.toDictionary()
            character.setValuesForKeys(characterAttributes)
            character.page = Int64(page)
            character.numPages = Int64(numPages)
        }
        
        saveContext()
    }
    
    func getAllCharacters() -> [Character] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Character> = Character.fetchRequest()
        
        do {
            let characters = try context.fetch(fetchRequest)
            return characters
        } catch {
            print("Error fetching characters: \(error.localizedDescription)")
            return []
        }
    }
    
    func getAllCharacters(page: Int) -> [Character] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Character> = Character.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "page == %lld", Int64(page))
        
        do {
            let characters = try context.fetch(fetchRequest)
            return characters
        } catch {
            print("Error fetching characters: \(error.localizedDescription)")
            return []
        }
    }
}
