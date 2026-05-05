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
                    //                    CoffeeBeanListRow(coffeeBean: bean)
                    NavigationLink {
                        CoffeeBeanDetailView(coffeeBean: bean)
                    } label: {
                        CoffeeBeanListRow(coffeeBean: bean)
                    }
                    .buttonStyle(.plain)
                    Divider().padding(.leading, 85)
                }
                .toolbar {
                    ToolbarItem {
                        toggleButton
                    }
                }
                .navigationTitle("All The Beans")
            }
        }
        .task {
            await viewModel.loadBeans()
        }
        
    }
}

extension CoffeeBeanListView {
    
    // MARK: Subviews
    
    private var toggleButton: some View {
        Button {
            viewModel.toggleLayout()
        } label: {
            Image(systemName: viewModel.layoutStyle == .list ? LayoutStyle.grid.toolBarImage : LayoutStyle.list.toolBarImage)
                .imageScale(.large)
        }
        
    }
}

#Preview {
    CoffeeBeanListView(viewModel: CoffeeBeanListViewModel(beanService: LocalBeanService()))
}
