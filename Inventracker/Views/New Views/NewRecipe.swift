//
//  NewRecipe.swift
//  Inventracker
//
//  Created by Carlos Rafael Reyes Magadán on 4/4/23.
//

import SwiftUI

struct NewRecipe: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    
    @State var name: String = ""
    
    var body: some View {
        Form {
            Section {
                TextField("Name of Recipe", text: $name)
                    .textFieldStyle(.automatic)
            }
            
            Section {
                Button("Add recipe") {
                    if name.isEmpty {
                        return
                    }
                    let recipe = Recipe(context: viewContext)
                    recipe.name = name
                    
                    saveContext(context: viewContext)
                    
                    dismiss()
                }
            } footer: {
                Text("Press to add a new recipe")
            }
        }
    }
}


struct NewRecipe_Previews: PreviewProvider {
    static var previews: some View {
        NewRecipe()
    }
}
