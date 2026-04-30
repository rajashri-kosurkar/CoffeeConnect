//
//  CoffeeBeanListViewModel.swift
//  CoffeeConnect
//
//  Created by Rajshri Kosurkar on 30/04/26.
//

import Foundation

@Observable
final class CoffeeBeanListViewModel {
    
    var coffeeBeans: [CoffeeBean] = []
    var isLoading: Bool = false
    var errorMessage: String? = nil
    
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

}
