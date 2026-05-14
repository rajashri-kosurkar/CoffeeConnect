//
//  OrderConfirmationView.swift
//  CoffeeConnect
//
//  Created by Rajshri Kosurkar on 14/05/26.
//

import SwiftUI

struct OrderConfirmationView: View {
    
    let orderFormViewModel: OrderFormViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            checkmarkImage
            orderDetails
            confirmationEmailDeatils
            Spacer()
            doneButton
        }
    }
}

extension OrderConfirmationView {
    
    // MARK: Subviews
    
    private var checkmarkImage: some View {
        
        Image(systemName: "checkmark.seal.fill")
            .font(.system(size: 72))
            .foregroundStyle(.green)
            .symbolEffect(.pulse)
    }
    
    private var orderDetails: some View {
        
        VStack {
            Text("Order Placed")
                .font(.largeTitle.bold())
            
            if let confirmation = orderFormViewModel.orderConfirmation {
                
                Text("Order ID: \(confirmation.orderId)")
                    .font(.headline)
                    .foregroundStyle(.secondary)
                Text("Estimated delivery: \(confirmation.estimateDelivery)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
    }
    
    private var confirmationEmailDeatils: some View {
        
        Text("Thank you for your order. You'll receive a confirmation email at \(orderFormViewModel.customerEmail).")
            .font(.body)
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 24)
        
    }
    
    private var doneButton: some View {
        Button("Done") { dismiss() }
            .buttonStyle(.borderedProminent)
    }
    
}

#Preview {
    let orderFormViewModel: OrderFormViewModel = OrderFormViewModel(coffeeBean: CoffeeBean.dummy)
    OrderConfirmationView(orderFormViewModel: orderFormViewModel)
    
}
