//
//  OrderFormViewModel.swift
//  CoffeeConnect
//
//  Created by Rajshri Kosurkar on 09/05/26.
//

import Foundation

@Observable
class OrderFormViewModel {
    
    // MARK: Form Fields
    var customerName: String = ""
    var customerEmail: String = ""
    var deliveryAddress: String = ""
    var specialNote: String = ""
    var quantity: Int = 1
    
    // MARK: Dependencies
    
    let coffeeBean: CoffeeBean
    private let orderService: OrderFormServiceProtocol
    
    // MARK: Init
    
    init(coffeeBean: CoffeeBean, orderService: OrderFormServiceProtocol = LocalOrderFormService()) {
        self.coffeeBean = coffeeBean
        self.orderService = orderService
    }
    
    // MARK: Helper
    
    var totalCost: String {
        guard let costValue = coffeeBean.costValue else {
            return coffeeBean.cost
        }
        let totalValue = costValue * Double(quantity)
        return String(format: "£%.2f", totalValue)
    }
}
