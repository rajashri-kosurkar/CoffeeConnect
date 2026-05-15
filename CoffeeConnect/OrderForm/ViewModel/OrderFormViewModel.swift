//
//  OrderFormViewModel.swift
//  CoffeeConnect
//
//  Created by Rajshri Kosurkar on 09/05/26.
//

import Foundation

@MainActor
@Observable
class OrderFormViewModel {
    
    // MARK: Form Fields
    var customerName: String = ""
    var customerEmail: String = ""
    var deliveryAddress: String = ""
    var specialNote: String = ""
    var quantity: Int = 1
    
    var nameError: String? = nil
    var emailError: String? = nil
    var addressError: String? = nil
    
    var orderConfirmation: OrderConfirmation? = nil
    var isOrderConfirmed: Bool = false
    var submissionError: String? = nil
    var isSubmitting: Bool = false
    
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
    
    // MARK: Validation Helpers
    
    func validateCustomerName() {
        nameError = customerName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        ? "Please enter your full name."
        : nil
    }
    
    func validateCustomerEmail() {
        let emailRegex = #"^[A-Z0-9a-z._%+\-]+@[A-Za-z0-9.\-]+\.[A-Za-z]{2,}$"#
        emailError = customerEmail.range(of: emailRegex, options: .regularExpression) == nil
        ? "Please enter a valid email address."
        : nil
    }
    
    func validateDeliveryAddress() {
        addressError = deliveryAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        ? "Please enter a delivery address."
        : nil
    }
    
    @discardableResult
    func validateAll() -> Bool {
        
        validateCustomerName()
        validateCustomerEmail()
        validateDeliveryAddress()
        
        // Returns true only if all errors are nil
        return nameError == nil && emailError == nil && addressError == nil
    }
    
    func submitCoffeeBeanOrder() async {
        
        guard validateAll() else { return }
        
        isSubmitting = true
        
        defer {
            isSubmitting = false
        }
        
        do {
            let order = buildOrder()
            let confirmation = try await orderService.submitOrder(order)
            orderConfirmation = confirmation
            isOrderConfirmed = true
        } catch {
            submissionError = error.localizedDescription
            isOrderConfirmed = false
        }
        
    }
    
    // MARK: Private
    
    private func buildOrder() -> Order {
        Order(coffeeBean: coffeeBean,
              quantity: quantity,
              customerName: customerName,
              customerEmail: customerEmail,
              deliveryAddress: deliveryAddress,
              specialNote: specialNote)
        
    }
    
}
