//
//  OrderSummaryRowView.swift
//  CoffeeConnect
//
//  Created by Rajshri Kosurkar on 09/05/26.
//

import SwiftUI

struct OrderSummaryRowView: View {
    let coffeeBean: CoffeeBean
    
    var body: some View {
        HStack(spacing: 12) {
            beanBackgroundImage
            beanDetails
            Spacer()
            beanCost
        }
    }
}

extension OrderSummaryRowView {
    // MARK: Subviews
    
    private var beanBackgroundImage: some View {
        AsyncImage(url: URL(string: coffeeBean.imageURL)) { image in
            image
                .resizable()
                .scaledToFill()
        } placeholder: {
            Color.brown.opacity(0.8)
        }
        .frame(width: 50, height: 50)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
    
    private var beanDetails: some View {
        
        VStack(alignment: .leading, spacing: 2) {
            Text(coffeeBean.name)
                .font(.headline)
                .lineLimit(1)
            
            HStack {
                Text(coffeeBean.country)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Circle()
                    .fill(Color.gray)
                    .frame(width: 5, height: 5)
                Text(coffeeBean.colour.capitalized)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
    }
    
    private var beanCost: some View {
        
        Text(coffeeBean.cost)
            .font(.subheadline.weight(.semibold))
            .foregroundStyle(.primary)
    }
}

#Preview {
    OrderSummaryRowView(coffeeBean: CoffeeBean.mockBeans[0])
}
