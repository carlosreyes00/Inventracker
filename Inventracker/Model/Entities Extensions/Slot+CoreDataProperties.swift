//
//  Slot+CoreDataProperties.swift
//  Inventracker
//
//  Created by Carlos Rafael Reyes Magadán on 4/28/23.
//
//

import Foundation
import CoreData


extension Slot {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Slot> {
        return NSFetchRequest<Slot>(entityName: "Slot")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var unitOfMeasureValue: String
    @NSManaged public var purchases: NSSet?
    @NSManaged public var ingredients: NSSet?
}

extension Slot {
    var quantity: Double {
        get {
            guard let sum = (self.purchases?.reduce(0) { $0 + ($1 as! Purchase).availableQuantity }) else {
                return 0
            }
            return sum
        }
    }
    
    var unitOfMeasure: UnitOfMeasure {
        get {
            return UnitOfMeasure(rawValue: String(self.unitOfMeasureValue)) ?? .grams
        }
        set {
            self.unitOfMeasureValue = String(newValue.rawValue)
        }
    }
}

// MARK: Generated accessors for purchases
extension Slot {

    @objc(addPurchasesObject:)
    @NSManaged public func addToPurchases(_ value: Purchase)

    @objc(removePurchasesObject:)
    @NSManaged public func removeFromPurchases(_ value: Purchase)

    @objc(addPurchases:)
    @NSManaged public func addToPurchases(_ values: NSSet)

    @objc(removePurchases:)
    @NSManaged public func removeFromPurchases(_ values: NSSet)

}

// MARK: Generated accessors for ingredients
extension Slot {

    @objc(addIngredientsObject:)
    @NSManaged public func addToIngredients(_ value: Ingredient)

    @objc(removeIngredientsObject:)
    @NSManaged public func removeFromIngredients(_ value: Ingredient)

    @objc(addIngredients:)
    @NSManaged public func addToIngredients(_ values: NSSet)

    @objc(removeIngredients:)
    @NSManaged public func removeFromIngredients(_ values: NSSet)

}

extension Slot : Identifiable {

}
