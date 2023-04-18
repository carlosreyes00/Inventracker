//
//  Persistence.swift
//  Inventracker
//
//  Created by Carlos Rafael Reyes Magadán on 4/3/23.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        for index in 0..<5 {
            let newRecipe = Recipe(context: viewContext)
            newRecipe.name = "recipe number \(index)"

            var set: NSSet = NSSet()

            let r = Int.random(in: 1...3)

            for index in 1...r {
                let ingredient = Ingredient(context: viewContext)
                ingredient.name = "Ingredient No. \(Int.random(in: 1...3))"
                ingredient.quantity = Double(index) * 100
                set = set.adding(ingredient) as NSSet
            }
            newRecipe.ingredients? = set
        }
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Inventracker")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
}
