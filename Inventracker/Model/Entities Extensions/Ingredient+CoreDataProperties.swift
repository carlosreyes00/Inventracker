//
//  Ingredient+CoreDataProperties.swift
//  Inventracker
//
//  Created by Carlos Rafael Reyes Magadán on 4/28/23.
//
//

import Foundation
import CoreData


extension Ingredient {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ingredient> {
        return NSFetchRequest<Ingredient>(entityName: "Ingredient")
    }
    
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var quantity: Double
    @NSManaged public var unitOfMeasureValue: String
    @NSManaged public var recipe: Recipe?
    @NSManaged public var slot: Slot?
    
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
            print("Price of ingredient \(self.name ?? "N/A")")
            
            let purchases = (slot?.purchases?.allObjects.filter({ !($0 as! Purchase).isFullyUsed }) as! [Purchase])
                .sorted { $0.date! < $1.date! }
            
            if purchases.count == 0 {
                return 0.0
            }
            
            //needed quantity
            var nQaux = quantity
            var total = 0.0

            purchases.forEach { purchase in
                let pricePerUnit = purchase.price / purchase.quantity
                let toUse = Double.minimum(nQaux, purchase.availableQuantity)

                nQaux -= toUse
                total += pricePerUnit * toUse

                if nQaux <= 0 {
                    return
                }
            }
            
            return total
        }
    }
    
    var neededQuantity: Double {
        get {
            return Double.maximum(0, quantity - (slot?.quantity ?? -1))
        }
    }
    
    var thereIsEnough: Bool {
        get {
            neededQuantity <= 0
        }
    }
}

extension Ingredient : Identifiable {
    
}
