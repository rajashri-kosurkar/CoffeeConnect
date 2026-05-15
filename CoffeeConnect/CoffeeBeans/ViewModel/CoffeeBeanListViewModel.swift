//
//  CoffeeBeanListViewModel.swift
//  CoffeeConnect
//
//  Created by Rajshri Kosurkar on 30/04/26.
//

import Foundation

enum LayoutStyle {
    case list
    case grid
    
    var toolBarImage : String {
        switch self {
        case .list:
            return "list.bullet"
        case .grid:
            return "square.grid.2x2"
        }
    }
}

@MainActor
@Observable
final class CoffeeBeanListViewModel {
    
    var coffeeBeans: [CoffeeBean] = []
    var isLoading: Bool = true
    var errorMessage: String? = "Failed to load the coffee beans data."
    var layoutStyle: LayoutStyle = .list
    var searchText: String = ""

    // MARK: Dependencies
    
    private let beanService: BeanServiceProtocol
    
    // MARK: Init
    
    init(beanService: BeanServiceProtocol = LocalBeanService()) {
        self.beanService = beanService
    }
    
    // MARK: Helpers

    var filteredBeans: [CoffeeBean] {
        guard !searchText.isEmpty else { return coffeeBeans }
        let query = searchText.lowercased()
        return coffeeBeans.filter { coffeeBeans in
            coffeeBeans.name.lowercased().contains(query) ||
            coffeeBeans.country.lowercased().contains(query) ||
            coffeeBeans.colour.lowercased().contains(query) ||
            coffeeBeans.description.lowercased().contains(query) ||
            coffeeBeans.cost.lowercased().contains(query)
        }
    }
    
    // MARK: Actions
    
    func loadBeans() async {
        isLoading = true
        errorMessage = nil
        do {
            coffeeBeans = try await beanService.fetchBeans()
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    
    func toggleLayout() {
        layoutStyle = (layoutStyle == .list) ? .grid : .list
    }
    
}
