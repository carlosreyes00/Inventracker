//
//  Recipe+CoreDataProperties.swift
//  Inventracker
//
//  Created by Carlos Rafael Reyes Magadán on 4/17/23.
//
//

import Foundation
import CoreData

extension Recipe {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recipe> {
        return NSFetchRequest<Recipe>(entityName: "Recipe")
    }
    
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var ingredients: NSSet?
    @NSManaged public var sales: NSSet?
    
}

extension Recipe {
    var cost : Double {
        get {
            guard let sum = self.ingredients?.reduce(0, { partialResult, ingredient in
                partialResult + (ingredient as! Ingredient).cost
            }) else {
                return -1
            }
            
            return sum
        }
    }
}

// MARK: Generated accessors for ingredients
extension Recipe {
    
    @objc(addIngredientsObject:)
    @NSManaged public func addToIngredients(_ value: Ingredient)
    
    @objc(removeIngredientsObject:)
    @NSManaged public func removeFromIngredients(_ value: Ingredient)
    
    @objc(addIngredients:)
    @NSManaged public func addToIngredients(_ values: NSSet)
    
    @objc(removeIngredients:)
    @NSManaged public func removeFromIngredients(_ values: NSSet)
    
}

// MARK: Generated accessors for sales
extension Recipe {
    
    @objc(addSalesObject:)
    @NSManaged public func addToSales(_ value: Sale)
    
    @objc(removeSalesObject:)
    @NSManaged public func removeFromSales(_ value: Sale)
    
    @objc(addSales:)
    @NSManaged public func addToSales(_ values: NSSet)
    
    @objc(removeSales:)
    @NSManaged public func removeFromSales(_ values: NSSet)
    
}

extension Recipe : Identifiable {
    
}
