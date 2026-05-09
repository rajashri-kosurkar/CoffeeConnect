//
//  CoffeeBeanListView.swift
//  CoffeeConnect
//
//  Created by Rajshri Kosurkar on 30/04/26.
//

import SwiftUI

struct CoffeeBeanListView: View {
    
    @Environment(CoffeeBeanListViewModel.self) var viewModel
    
    var body: some View {
        
        NavigationStack {
            
            Group {
                if viewModel.isLoading {
                    loadingView
                } else if viewModel.errorMessage != nil {
                    errorView
                } else {
                    beanContentView
                }
            }
            .toolbar {
                ToolbarItem {
                    toggleButton
                }
            }
            .navigationTitle("All The Beans")
            
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
    
    private var loadingView: some View {
        VStack(spacing: 16) {
            ProgressView()
            Text("Brewing the beans...")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }
    
    private var errorView: some View {
        VStack(spacing: 20) {
            Image(systemName: "exclamationmark.circle")
                .font(.system(size: 50))
                .foregroundStyle(.red)
            Text("Something went wrong")
                .font(.title3.weight(.semibold))
            Text(viewModel.errorMessage ?? "Failed to load coffee beans...")
                .font(.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
    }
    
    private var beanContentView: some View {
        Group {
            ScrollView {
                if viewModel.layoutStyle == .list {
                    listContentView
                } else {
                    gridContentView
                }
            }
        }
    }
    
    private var listContentView: some View {
        
        LazyVStack(spacing: 10) {
            ForEach(viewModel.coffeeBeans) { bean in
                NavigationLink {
                    CoffeeBeanDetailView(coffeeBean: bean)
                } label: {
                    CoffeeBeanListRow(coffeeBean: bean)
                }
                .buttonStyle(.plain)
                Divider().padding(.leading, 85)
                
            }
        }
        .padding(.top, 8)
    }
    private var gridContentView: some View {
        Text("Grid content")
    }
}

#Preview {
    //    CoffeeBeanListView(viewModel: CoffeeBeanListViewModel(beanService: LocalBeanService()))
    let vm = CoffeeBeanListViewModel(beanService: MockBeanService())
    Task { [weak vm] in await vm?.loadBeans() }
    return CoffeeBeanListView().environment(vm)
}
