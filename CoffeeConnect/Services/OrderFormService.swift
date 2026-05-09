//
//  OrderFormService.swift
//  CoffeeConnect
//
//  Created by Rajshri Kosurkar on 09/05/26.
//

import Foundation

// MARK: - OrderFormServiceProtocol

protocol OrderFormServiceProtocol {
    func submitOrder(_ order: Order) async throws -> OrderConfirmation
}

// MARK: - OrderConfirmation

struct OrderConfirmation {
    let orderId: String
    let estimateDelivery: String
}

// MARK: - OrderFormServiceError

enum OrderFormServiceError: LocalizedError {
    case validationFailed(String)
    case submissionFailed
    
    var errorDescription: String? {
        switch self {
        case .validationFailed(let message):
            return message
        case .submissionFailed:
            return "Order submission failed. Please try again."
        }
    }
}

// MARK: - LocalOrderFormService (Primary Implementation)

final class LocalOrderFormService: OrderFormServiceProtocol {
    func submitOrder(_ order: Order) async throws -> OrderConfirmation {
        
        do {
            try order.validate()
        } catch let validationErrorString as OrderFormValidationError {
            throw OrderFormServiceError.validationFailed(validationErrorString.errorDescription ?? "Validation failed")
        }
        
        // Simulate the newtork call
        try await Task.sleep(nanoseconds: 500_000_000)
        
        let orderID = "\(Int.random(in: 10000...99999))"
        let delivery = "3-5 working days"
        return OrderConfirmation(orderId: orderID, estimateDelivery: delivery)
    }
}

// MARK: - MockOrderService (For Testing & Previews)

final class MockOrderService: OrderFormServiceProtocol {
    var shouldFail: Bool = false

    func submitOrder(_ order: Order) async throws -> OrderConfirmation {
        if shouldFail {
            throw OrderFormServiceError.submissionFailed
        }
        try order.validate()
        return OrderConfirmation(orderId: "OrderId- 1234", estimateDelivery: "3-5 working days")
    }
}
