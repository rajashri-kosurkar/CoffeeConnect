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

@Observable
final class CoffeeBeanListViewModel {
    
    var coffeeBeans: [CoffeeBean] = []
    var isLoading: Bool = true
    var errorMessage: String? = "Failed to load the coffee beans data."
    var layoutStyle: LayoutStyle = .list
    
    // MARK: Dependencies
    
    private let beanService: BeanServiceProtocol
    
    // MARK: Init
    
    init(beanService: BeanServiceProtocol = LocalBeanService()) {
        self.beanService = beanService
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
