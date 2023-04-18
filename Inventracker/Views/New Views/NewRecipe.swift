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
        NavigationStack {
            Form {
                Section {
                    TextField("Name of Recipe", text: $name)
                        .textFieldStyle(.automatic)
                }
            }
            .toolbar {
                ToolbarItem {
                    Button("Add recipe") {
                        let _ = createRecipe(name: name, in: viewContext)
                        dismiss()
                    }
                    .disabled(name.isEmpty)
                }
            }
        }
    }
}


struct NewRecipe_Previews: PreviewProvider {
    static var previews: some View {
        NewRecipe()
    }
}
