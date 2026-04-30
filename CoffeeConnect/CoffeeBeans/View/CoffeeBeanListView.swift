//
//  CoffeeBeanListView.swift
//  CoffeeConnect
//
//  Created by Rajshri Kosurkar on 30/04/26.
//

import SwiftUI

struct CoffeeBeanListView: View {
    
    @State var viewModel: CoffeeBeanListViewModel
    
    var body: some View {
            
            NavigationStack {
                ScrollView {
                    ForEach(viewModel.coffeeBeans) { bean in
                        CoffeeBeanListRow(coffeeBean: bean)
                                }
                    .navigationTitle("All The Beans")
                }
            }
            .task {
                await viewModel.loadBeans()
            }
            
        }
}

#Preview {
    CoffeeBeanListView(viewModel: CoffeeBeanListViewModel(beanService: LocalBeanService()))
}
