//
//  CoffeeBeanListView.swift
//  CoffeeConnect
//
//  Created by Rajshri Kosurkar on 30/04/26.
//

import SwiftUI

struct CoffeeBeanListView: View {
    
    @Environment(CoffeeBeanListViewModel.self) var viewModel
    
    // Grid layout columns
    private let gridColumns: [GridItem] = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        
        @Bindable var viewModel = viewModel
        
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
            .searchable(
                text: $viewModel.searchText,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Search by name, country, colour, cost"
            )
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
            if viewModel.filteredBeans.isEmpty {
                emptyStateView
            } else {
                ScrollView {
                    if viewModel.layoutStyle == .list {
                        listContentView
                    } else {
                        gridContentView
                    }
                }
            }
            
        }
    }
    
    private var listContentView: some View {
        
        LazyVStack(spacing: 10) {
            ForEach(viewModel.filteredBeans) { bean in
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
        LazyVGrid(columns: gridColumns, spacing: 16) {
            
            ForEach(viewModel.filteredBeans) { bean in
                NavigationLink {
                    CoffeeBeanDetailView(coffeeBean: bean)
                } label: {
                    CoffeeBeanGridRowView(coffeeBean: bean)
                }
                .buttonStyle(.plain)
                
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 8)
    }
    
    private var emptyStateView: some View {
        ContentUnavailableView.search(text: viewModel.searchText)
    }
}

#Preview {
    let vm = CoffeeBeanListViewModel(beanService: MockBeanService())
    Task { [weak vm] in await vm?.loadBeans() }
    return CoffeeBeanListView().environment(vm)
}
