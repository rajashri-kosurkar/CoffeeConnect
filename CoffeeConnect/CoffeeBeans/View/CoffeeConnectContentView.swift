//
//  CoffeeConnectContentView.swift
//  CoffeeConnect
//
//  Created by Rajshri Kosurkar on 30/04/26.
//

import SwiftUI

struct CoffeeConnectContentView: View {
    
    @State var coffeeBeanListViewModel: CoffeeBeanListViewModel = CoffeeBeanListViewModel()
    
    var body: some View {
        
        TabView {
            CoffeeBeanListView(viewModel: coffeeBeanListViewModel)
                .tabItem {
                    Label("Beans", systemImage: "cup.and.saucer.fill")
                }
            
            Text("Bean of the day View")
                .tabItem {
                    Label("Bean of the Day", systemImage: "star.fill")
                }
        }
    }
}

#Preview {
    CoffeeConnectContentView()
}
