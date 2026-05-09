//
//  OrderFormView.swift
//  CoffeeConnect
//
//  Created by Rajshri Kosurkar on 09/05/26.
//

import SwiftUI

struct OrderFormView: View {
    
    @Bindable var orderFormViewModel: OrderFormViewModel
    
    var body: some View {
        NavigationStack{
            Group {
                formView
            }
            .navigationTitle("Order \(orderFormViewModel.coffeeBean.name)")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

extension OrderFormView {
    
    // MARK: - Form

        private var formView: some View {
            Form {
                
                // Coffee Bean Summary
                OrderSummaryRowView(coffeeBean: orderFormViewModel.coffeeBean)
                
                // Quantity Detail
                Section("Quantity Detail") {
                    Stepper("Quantity: \(orderFormViewModel.quantity)", value: $orderFormViewModel.quantity, in: 1...99)

                }
                
                // Customer Details
                Section(header: Text("Your Details")) {
                    TextField("Enter your name", text: $orderFormViewModel.customerName)
                        .keyboardType(.default)
                    
                    TextField("Enter your email", text: $orderFormViewModel.customerEmail)
                        .keyboardType(.emailAddress)

                }
                
                // Customer Address
                Section(header: Text("Delivery Address")) {
                    TextField("Enter Delivery Address", text: $orderFormViewModel.deliveryAddress)
                        .keyboardType(.default)
                }
                
                // Additional Note
                Section(header: Text("Additional Note(Optional)")) {
                    TextEditor(text: $orderFormViewModel.specialNote)
                        .frame(height: 80)
                }

                // Total Cost & Place Order Button
                Section {
                    HStack {
                        Text("Total")
                            .font(.headline)
                        Spacer()
                        Text("\(orderFormViewModel.totalCost)")
                            .font(.headline)
                    }
                    Button {
                      
                    } label: {
                        Label("Place Order", systemImage: "checkmark.circle.fill")
                            .labelStyle(.titleAndIcon)
                            .frame(maxWidth: .infinity)
                            .frame(height: 55)
                            .font(.headline.bold())
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
        }
}

#Preview {
    let orderFormViewModel: OrderFormViewModel = OrderFormViewModel(coffeeBean: CoffeeBean.dummy)
        OrderFormView(orderFormViewModel: orderFormViewModel)
}
