//
//  CoffeeConnectContentView.swift
//  CoffeeConnect
//
//  Created by Rajshri Kosurkar on 30/04/26.
//

import SwiftUI

struct CoffeeConnectContentView: View {
    
    @State private var coffeeBeanListViewModel: CoffeeBeanListViewModel = CoffeeBeanListViewModel()
    
    var body: some View {
        
        TabView {
            CoffeeBeanListView()
                .tabItem {
                    Label("Beans", systemImage: "cup.and.saucer.fill")
                }
                .environment(coffeeBeanListViewModel)
            
            BeanOfTheDayView(coffeeBean:CoffeeBean.mockBeans[0])
                .tabItem {
                    Label("Bean of the Day", systemImage: "star.fill")
                }
        }
    }
}

#Preview {
    CoffeeConnectContentView()
}
