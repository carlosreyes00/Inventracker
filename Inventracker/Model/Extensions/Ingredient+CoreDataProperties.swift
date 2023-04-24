//
//  Ingredient+CoreDataProperties.swift
//  Inventracker
//
//  Created by Carlos Rafael Reyes Magadán on 4/12/23.
//
//

import Foundation
import CoreData
import SwiftUI


extension Ingredient {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ingredient> {
        return NSFetchRequest<Ingredient>(entityName: "Ingredient")
    }
    
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var quantity: Double
    @NSManaged public var neededQuantity: Double
    @NSManaged public var unitOfMeasureValue: String
    @NSManaged public var recipe: Recipe?
    @NSManaged public var thereIsEnough: Bool
}

extension Ingredient {
    var unitOfMeasure: UnitOfMeasure {
        get {
            return UnitOfMeasure(rawValue: String(self.unitOfMeasureValue)) ?? .grams
        }
        set {
            self.unitOfMeasureValue = String(newValue.rawValue)
        }
    }
    
    var cost: Double {
        get {
            let viewContext = PersistenceController.shared.container.viewContext
            
            let fetchRequest = Purchase.fetchRequest()
            
            let predicateSlot = NSPredicate(format: "slot.name = %@", self.name ?? "no name")
            let predicateIsFullyUsed = NSPredicate(format: "isFullyUsed = %@", false as NSNumber)
            fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicateSlot, predicateIsFullyUsed])
            
            fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Purchase.date, ascending: true)]
            
            let purchases: [Purchase]
            
            do {
                purchases = try viewContext.fetch(fetchRequest)
            } catch {
                fatalError(error.localizedDescription)
            }
            
            neededQuantity = self.quantity
            var value = 0.0
            
            purchases.forEach({ purchase in
                let pricePerUnit = purchase.price / purchase.quantity
                let toUse = Double.minimum(neededQuantity, purchase.availableQuantity)
                
                neededQuantity -= toUse
                value += pricePerUnit * toUse
                
                if neededQuantity <= 0 {
                    thereIsEnough = true
                    neededQuantity = 0
                    return
                }
                thereIsEnough = false
            })
            
            return value
        }
    }
}

extension Ingredient : Identifiable {
    
}
