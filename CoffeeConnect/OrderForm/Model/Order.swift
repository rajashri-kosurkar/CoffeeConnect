//
//  Order.swift
//  CoffeeConnect
//
//  Created by Rajshri Kosurkar on 09/05/26.
//

import Foundation

struct Order: Identifiable {
    
    let id: UUID
    let coffeeBean: CoffeeBean
    let quantity: Int
    let customerName: String
    let customerEmail: String
    let deliveryAddress: String
    let specialNote: String?
    
    init(id: UUID = UUID(), coffeeBean: CoffeeBean, quantity: Int, customerName: String, customerEmail: String, deliveryAddress: String, specialNote: String?) {
        self.id = id
        self.coffeeBean = coffeeBean
        self.quantity = quantity
        self.customerName = customerName
        self.customerEmail = customerEmail
        self.deliveryAddress = deliveryAddress
        self.specialNote = specialNote
    }
    
}

// MARK: - Order Validation

struct OrderFormValidationError: LocalizedError {
    let field: String
    let message: String
    
    var errorDescription: String? { "\(field): \(message)" }
}

extension Order {
    func validate() throws {
        if customerName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            throw OrderFormValidationError(field: "Name", message: "Please enter your full name.")
        }
        let emailRegex = #"^[A-Z0-9a-z._%+\-]+@[A-Za-z0-9.\-]+\.[A-Za-z]{2,}$"#
        guard customerEmail.range(of: emailRegex, options: .regularExpression) != nil else {
            throw OrderFormValidationError(field: "Email", message: "Please enter a valid email address.")
        }
        if deliveryAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            throw OrderFormValidationError(field: "Address", message: "Please enter a delivery address.")
        }
        if quantity < 1 || quantity > 99 {
            throw OrderFormValidationError(field: "Quantity", message: "Quantity must be between 1 and 99.")
        }
    }
}

