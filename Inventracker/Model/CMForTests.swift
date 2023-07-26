//
//  CMForTests.swift
//  Inventracker
//
//  Created by Carlos Rafael Reyes Magadán on 6/13/23.
//

import Foundation
import CoreData

func deleteProductsToTesting(in context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
    context.registeredObjects.forEach {
        context.delete($0)
    }
    
    saveContext(context: context)
}

func addProductsToTesting(in context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
    
    let merengue = createRecipe(name: "Merengue")
    addIngredient(name: "Eggs", quantity: 2, unitOfMeasure: .units, to: merengue)
    addIngredient(name: "Sugar", quantity: 200, unitOfMeasure: .grams, to: merengue)
    addIngredient(name: "Vanilla", quantity: 10, unitOfMeasure: .grams, to: merengue)
    addIngredient(name: "Ing 00", quantity: 50, unitOfMeasure: .grams, to: merengue)
    addIngredient(name: "Ing 01", quantity: 50, unitOfMeasure: .grams, to: merengue)
    addIngredient(name: "Ing 02", quantity: 50, unitOfMeasure: .grams, to: merengue)
    addIngredient(name: "Ing 03", quantity: 50, unitOfMeasure: .grams, to: merengue)
    addIngredient(name: "Ing 04", quantity: 50, unitOfMeasure: .grams, to: merengue)
    addIngredient(name: "Ing 05", quantity: 50, unitOfMeasure: .grams, to: merengue)
    addIngredient(name: "Ing 06", quantity: 50, unitOfMeasure: .grams, to: merengue)
    
    let brownie = createRecipe(name: "Brownie")
    addIngredient(name: "Eggs", quantity: 4, unitOfMeasure: .units, to: brownie)
    addIngredient(name: "Sugar", quantity: 170, unitOfMeasure: .grams, to: brownie)
    addIngredient(name: "Chocolate", quantity: 200, unitOfMeasure: .grams, to: brownie)
    addIngredient(name: "Honey", quantity: 21, unitOfMeasure: .grams, to: brownie)
    addIngredient(name: "Ing 00", quantity: 50, unitOfMeasure: .grams, to: brownie)
    addIngredient(name: "Ing 01", quantity: 50, unitOfMeasure: .grams, to: brownie)
    addIngredient(name: "Ing 02", quantity: 50, unitOfMeasure: .grams, to: brownie)
    addIngredient(name: "Ing 03", quantity: 50, unitOfMeasure: .grams, to: brownie)
    addIngredient(name: "Ing 04", quantity: 50, unitOfMeasure: .grams, to: brownie)
    addIngredient(name: "Ing 05", quantity: 50, unitOfMeasure: .grams, to: brownie)
    addIngredient(name: "Ing 06", quantity: 50, unitOfMeasure: .grams, to: brownie)
    
    
    let request: NSFetchRequest<Slot> = NSFetchRequest(entityName: "Slot")
    var slots: [Slot]
    
    do {
        request.predicate = NSPredicate(format: "name == %@", "Eggs")
        slots = try context.fetch(request)
        addPurchase(date: Date(), price: 0.5, quantity: 10, slot: slots.first!)
        addPurchase(date: Date(), price: 0.25, quantity: 10, slot: slots.first!)
        addPurchase(date: Date(), price: 2, quantity: 2, slot: slots.first!)
        addPurchase(date: Date(), price: 120, quantity: 12, slot: slots.first!)
    } catch {
        print("Error fetching Eggs slot ]--> \(error)")
    }
    
    do {
        request.predicate = NSPredicate(format: "name == %@", "Sugar")
        slots = try context.fetch(request)
        addPurchase(date: Date(), price: 5, quantity: 200, slot: slots.first!)
        addPurchase(date: Date(), price: 5, quantity: 200, slot: slots.first!)
        addPurchase(date: Date(), price: 5, quantity: 200, slot: slots.first!)
    } catch {
        print("Error fetching Sugar slot ]--> \(error)")
    }
    
    do {
        request.predicate = NSPredicate(format: "name == %@", "Vanilla")
        slots = try context.fetch(request)
        addPurchase(date: Date(), price: 2, quantity: 50, slot: slots.first!)
        addPurchase(date: Date(), price: 2, quantity: 50, slot: slots.first!)
    } catch {
        print("Error fetching Vanilla slot ]--> \(error)")
    }
    
    do {
        request.predicate = NSPredicate(format: "name == %@", "Chocolate")
        slots = try context.fetch(request)
        addPurchase(date: Date(), price: 50, quantity: 25, slot: slots.first!)
        addPurchase(date: Date(), price: 2, quantity: 50, slot: slots.first!)
    } catch {
        print("Error fetching Chocolate slot ]--> \(error)")
    }
    
    do {
        request.predicate = NSPredicate(format: "name == %@", "Honey")
        slots = try context.fetch(request)
        addPurchase(date: Date(), price: 5, quantity: 150, slot: slots.first!)
        addPurchase(date: Date(), price: 2, quantity: 50, slot: slots.first!)
    } catch {
        print("Error fetching Honey slot ]--> \(error)")
    }
}

//func addProductsToTesting(in context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
//    let brownieRecipe = createRecipe(name: "Brownie")
//    addIngredient(name: "Butter", quantity: 200, unitOfMeasure: .grams, to: brownieRecipe)
//    addIngredient(name: "Sugar", quantity: 170, unitOfMeasure: .grams, to: brownieRecipe)
//    addIngredient(name: "Eggs", quantity: 4, unitOfMeasure: .units, to: brownieRecipe)
//    addIngredient(name: "Honey", quantity: 21, unitOfMeasure: .grams, to: brownieRecipe)
//    addIngredient(name: "Flour", quantity: 170, unitOfMeasure: .grams, to: brownieRecipe)
//    addIngredient(name: "Cacao", quantity: 70, unitOfMeasure: .grams, to: brownieRecipe)
//    addIngredient(name: "Baking Powder", quantity: 4, unitOfMeasure: .grams, to: brownieRecipe)
//    addIngredient(name: "Salt", quantity: 3, unitOfMeasure: .grams, to: brownieRecipe)
//    addIngredient(name: "Nuts", quantity: 37.6, unitOfMeasure: .grams, to: brownieRecipe)
//    addIngredient(name: "Sirope", quantity: 150, unitOfMeasure: .grams, to: brownieRecipe)
//    addIngredient(name: "Box", quantity: 1, unitOfMeasure: .units, to: brownieRecipe)
//    addIngredient(name: "Sticker", quantity: 1, unitOfMeasure: .units, to: brownieRecipe)
//
//    let cookiesRecipe = createRecipe(name: "Cookies")
//    addIngredient(name: "Butter", quantity: 100, unitOfMeasure: .grams, to: cookiesRecipe)
//    addIngredient(name: "Sugar", quantity: 55, unitOfMeasure: .grams, to: cookiesRecipe)
//    addIngredient(name: "Brown Sugar", quantity: 85, unitOfMeasure: .grams, to: cookiesRecipe)
//    addIngredient(name: "Salt", quantity: 3, unitOfMeasure: .grams, to: cookiesRecipe)
//    addIngredient(name: "Vanilla", quantity: 4.9, unitOfMeasure: .mililiters, to: cookiesRecipe)
//    addIngredient(name: "Eggs", quantity: 1, unitOfMeasure: .units, to: cookiesRecipe)
//    addIngredient(name: "Flour", quantity: 145, unitOfMeasure: .grams, to: cookiesRecipe)
//    addIngredient(name: "Baking Soda", quantity: 2.4, unitOfMeasure: .grams, to: cookiesRecipe)
//    addIngredient(name: "Chocolate Chunks", quantity: 170, unitOfMeasure: .grams, to: cookiesRecipe)
//    addIngredient(name: "Box", quantity: 1, unitOfMeasure: .units, to: cookiesRecipe)
//    addIngredient(name: "Sticker", quantity: 1, unitOfMeasure: .units, to: cookiesRecipe)

//    do {
//        request.predicate = NSPredicate(format: "name == %@", "Butter")
//        slots = try context.fetch(request)
//        addPurchase(date: Date(), price: 13.79, quantity: 1812, slot: slots.first!)
//    } catch {
//        print("Error fetching Butter slot")
//    }
//
//    do {
//        request.predicate = NSPredicate(format: "name == %@", "Brown Sugar")
//        slots = try context.fetch(request)
//        addPurchase(date: Date(), price: 3.00, quantity: 680, slot: slots.first!)
//    } catch {
//        print("Error fetching Sugar slot")
//    }
//
//    do {
//        request.predicate = NSPredicate(format: "name == %@", "Cacao")
//        slots = try context.fetch(request)
//        addPurchase(date: Date(), price: 6.49, quantity: 1275, slot: slots.first!)
//    } catch {
//        print("Error fetching Cacao slot")
//    }
//
//    do {
//        request.predicate = NSPredicate(format: "name == %@", "Salt")
//        slots = try context.fetch(request)
//        addPurchase(date: Date(), price: 5.66, quantity: 2267.96, slot: slots.first!)
//    } catch {
//        print("Error fetching Salt slot")
//    }
//
//
//    do {
//        request.predicate = NSPredicate(format: "name == %@", "Flour")
//        slots = try context.fetch(request)
//        addPurchase(date: Date(), price: 2.24, quantity: 2260, slot: slots.first!)
//    } catch {
//        print("Error fetching Flour slot")
//    }
//
//    do {
//        request.predicate = NSPredicate(format: "name == %@", "Baking Powder")
//        slots = try context.fetch(request)
//        addPurchase(date: Date(), price: 14.43, quantity: 1814.37, slot: slots.first!)
//    } catch {
//        print("Error fetching Baking Powder slot")
//    }
//
//    do {
//        request.predicate = NSPredicate(format: "name == %@", "Baking Soda")
//        slots = try context.fetch(request)
//        addPurchase(date: Date(), price: 14.43, quantity: 1814.37, slot: slots.first!)
//    } catch {
//        print("Error fetching Baking Soda slot")
//    }
//
//    do {
//        request.predicate = NSPredicate(format: "name == %@", "Honey")
//        slots = try context.fetch(request)
//        addPurchase(date: Date(), price: 4.59, quantity: 340.19, slot: slots.first!)
//    } catch {
//        print("Error fetching Honey slot")
//    }
//
//    do {
//        request.predicate = NSPredicate(format: "name == %@", "Nuts")
//        slots = try context.fetch(request)
//        addPurchase(date: Date(), price: 2.46, quantity: 113, slot: slots.first!)
//    } catch {
//        print("Error fetching Nuts slot")
//    }
//
//    do {
//        request.predicate = NSPredicate(format: "name == %@", "Sirope")
//        slots = try context.fetch(request)
//        addPurchase(date: Date(), price: 10.32, quantity: 3400, slot: slots.first!)
//    } catch {
//        print("Error fetching Sirope slot")
//    }
//
//    do {
//        request.predicate = NSPredicate(format: "name == %@", "Chocolate Chunks")
//        slots = try context.fetch(request)
//        addPurchase(date: Date(), price: 2.32, quantity: 340, slot: slots.first!)
//    } catch {
//        print("Error fetching Chocolate Chunks slot")
//    }
//
//    do {
//        request.predicate = NSPredicate(format: "name == %@", "Box")
//        slots = try context.fetch(request)
//        addPurchase(date: Date(), price: 21.28, quantity: 20, slot: slots.first!)
//    } catch {
//        print("Error fetching Box slot")
//    }
//
//    do {
//        request.predicate = NSPredicate(format: "name == %@", "Sticker")
//        slots = try context.fetch(request)
//        addPurchase(date: Date(), price: 2.56, quantity: 6, slot: slots.first!)
//    } catch {
//        print("Error fetching Sticker slot")
//    }
//}
