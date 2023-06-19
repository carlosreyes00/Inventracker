//
//  ContentView.swift
//  Inventracker
//
//  Created by Carlos Rafael Reyes Magadán on 4/3/23.
//

import SwiftUI


struct ContentView: View {
    
    var body: some View {
        TabView {
            Recipes()
                .tabItem {
                    Label("Recipes", systemImage: "fork.knife" )
                }
            
            Purchases()
                .tabItem {
                    Label("Purchases", systemImage: "list.bullet.below.rectangle" )
                }
            
            Sales()
                .tabItem {
                    Label("Sales", systemImage: "chart.line.uptrend.xyaxis")
                }
            
            Managment()
                .tabItem {
                    Label("Managment", systemImage: "books.vertical")
                }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
