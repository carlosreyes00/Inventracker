//
//  Slot+CoreDataProperties.swift
//  Inventracker
//
//  Created by Carlos Rafael Reyes Magadán on 4/12/23.
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
    @NSManaged public var purchases: NSSet?
    @NSManaged public var unitOfMeasureValue: String
    
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

extension Slot {
    var availableQuantity: Double {
        get {
            let sum = self.purchases?.reduce(0) { $0 + ($1 as! Purchase).quantity }
            return sum!
        }
    }
    
    var unitOfMeasure: UnitOfMeasure {
        get {
            return UnitOfMeasure(rawValue: String(self.unitOfMeasureValue))!
        }
        set {
            self.unitOfMeasureValue = String(newValue.rawValue)
        }
    }
}

extension Slot : Identifiable {

}
