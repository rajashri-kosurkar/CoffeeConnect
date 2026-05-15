//
//  CoffeeBeanGridRowView.swift
//  CoffeeConnect
//
//  Created by Rajshri Kosurkar on 09/05/26.
//

import SwiftUI

struct CoffeeBeanGridRowView: View {
    let coffeeBean: CoffeeBean
    
    var body: some View {
        VStack(alignment: .leading) {
            beanBackgroundImage
            beanDetails
        }
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

extension CoffeeBeanGridRowView {
    
    // MARK: Subviews
    
    private var beanBackgroundImage: some View {
        
        ZStack(alignment: .topTrailing) {
            AsyncImage(url: URL(string: coffeeBean.imageURL)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Color.brown.opacity(0.8)
            }
            .frame(height: 120)
            .clipped()
            
            if coffeeBean.isBOTD {
                BOTDBadge()
                    .padding(10)
            }
        }
    }
    
    private var beanDetails: some View {
        VStack(alignment: .leading) {
            Text(coffeeBean.name)
                .font(.headline)
                .lineLimit(1)
            Text(coffeeBean.country)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            
            Text(coffeeBean.cost)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.primary)
        }
        .padding(10)
    }
}


#Preview {
    CoffeeBeanGridRowView(coffeeBean: CoffeeBean.mockBeans[0])
}
