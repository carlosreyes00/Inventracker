//
//  ContextManagment.swift
//  Inventracker
//
//  Created by Carlos Rafael Reyes Magadán on 4/6/23.
//

import Foundation
import CoreData
import SwiftUI

func saveContext(context: NSManagedObjectContext) {
    do {
        try context.save()
    } catch {
        let nsError = error as NSError
        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
    }
}

func deleteObject<T: NSManagedObject>(object: T, context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
    context.delete(object)
    
    saveContext(context: context)
}

func deleteObjects<T: NSManagedObject>(objects: FetchedResults<T>, context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
    objects.forEach(context.delete)
    
    saveContext(context: context)
}

func createRecipe(name: String, in context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) -> Recipe {
    let newRecipe = Recipe(context: context)
    newRecipe.name = name
    
    saveContext(context: context)
    
    return newRecipe
}

func addIngredient(name: String, quantity: Double, unitOfMeasure: UnitOfMeasure, to recipe: Recipe, in context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
    
    let newIngredient = Ingredient(context: context)
    newIngredient.name = name
    newIngredient.quantity = quantity
    newIngredient.unitOfMeasure = unitOfMeasure
    
    recipe.addToIngredients(newIngredient)
    
    let slot = Slot(context: context)
    slot.name = name
    slot.unitOfMeasure = unitOfMeasure
    
    slot.addToIngredients(newIngredient)
    
    saveContext(context: context)
}

func addPurchase(date: Date, price: Double, quantity: Double, slot: Slot, in context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
    let purchase = Purchase(context: context)
    purchase.date = date
    purchase.price = price
    purchase.quantity = quantity
    purchase.availableQuantity = quantity
    purchase.isFullyUsed = false
    
    slot.addToPurchases(purchase)
    
    slot.ingredients?.allObjects.forEach { ingredient in
        context.refresh((ingredient as! Ingredient).recipe!, mergeChanges: true)
    }
    
    slot.ingredients?.allObjects.forEach { ingredient in
        context.refresh(ingredient as! Ingredient, mergeChanges: true)
    }
    
    saveContext(context: context)
}

func addSale(date: Date, recipe: Recipe, price: Double, in context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
    let sale = Sale(context: context)
    sale.date = date
    sale.price = price
    sale.cost = recipe.cost
    sale.profit = price - sale.cost
    
    recipe.addToSales(sale)
    
    saveContext(context: context)
}

//TODO: function to perform a sale
func makeSale(recipe: Recipe) {
    if !recipe.canBeSold {
        print("\(recipe.name ?? "N/A") can't be sold")
        return
    }
}
