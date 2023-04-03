//
//  NewIngredient.swift
//  Inventracker
//
//  Created by Carlos Rafael Reyes Magadán on 4/3/23.
//

import SwiftUI

struct NewIngredient: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @Environment(\.dismiss) var dismiss
    
    @State var name: String = ""
    
    var body: some View {
        VStack {
            TextField("Name of Ingredient", text: $name)
                .textFieldStyle(.roundedBorder)
            Button("Save") {
                let ingredient = Ingredient(context: viewContext)
                ingredient.name = name
                
                do {
                    try viewContext.save()
                } catch {
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                    
                }
                
                dismiss()
            }
        }
        .padding()
    }
}

struct NewIngredient_Previews: PreviewProvider {
    static var previews: some View {
        NewIngredient()
    }
}
