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
    @NSManaged public var unitOfMeasureValue: String
    @NSManaged public var recipe: Recipe?
    
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
            fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Purchase.date, ascending: true)]
            fetchRequest.predicate = NSPredicate(format: "slot.name = %@", self.name ?? "no name")
            
            let purchases: [Purchase]
            
            do {
                purchases = try viewContext.fetch(fetchRequest)
            } catch {
                fatalError(error.localizedDescription)
            }
            
            var rest = self.quantity
            var value = 0.0
            
            purchases.forEach({ purchase in
                let pricePerUnit = purchase.price / purchase.quantity
                let toUse = Double.minimum(rest, purchase.quantity)
                
                rest -= toUse
                value += pricePerUnit * toUse
                
                if rest <= 0 {
                    return
                }
            })
            
            return value
        }
    }
}

extension Ingredient : Identifiable {
    
}
