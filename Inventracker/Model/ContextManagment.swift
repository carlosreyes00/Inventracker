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
        // Replace this implementation with code to handle the error appropriately.
        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        let nsError = error as NSError
        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
    }
}

func deleteObject<T: NSManagedObject>(object: T, context: NSManagedObjectContext) {
    context.delete(object)
}

func deleteObjects<T: NSManagedObject>(objects: FetchedResults<T>, context: NSManagedObjectContext) {
    objects.forEach(context.delete)
}

func createRecipe(name: String, in context: NSManagedObjectContext) {
    let newRecipe = Recipe(context: context)
    newRecipe.name = name
}

func addIngredient(to recipe: Recipe, in context: NSManagedObjectContext) {
    
}
