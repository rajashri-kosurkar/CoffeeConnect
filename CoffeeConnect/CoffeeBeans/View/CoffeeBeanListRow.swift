//
//  CoffeeBeanListRow.swift
//  CoffeeConnect
//
//  Created by Rajshri Kosurkar on 30/04/26.
//

import SwiftUI

struct CoffeeBeanListRow: View {
    let coffeeBean: CoffeeBean
    
    var body: some View {
        HStack(spacing: 12) {
            beanBackgroundImage
            beanDetails
            Spacer()
            beanCost
        }
        .padding(.horizontal, 16)
    }
}

extension CoffeeBeanListRow {
    
    // MARK: Subviews
    
    private var beanBackgroundImage: some View {
        
        AsyncImage(url: URL(string: coffeeBean.imageURL)) { image in
            image
                .resizable()
                .scaledToFill()
        } placeholder: {
            Color.brown.opacity(0.2)
        }
        .frame(width: 64, height: 64)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        
    }
    
    private var beanDetails: some View {
        
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(coffeeBean.name)
                    .font(.headline)
                    .lineLimit(1)
                if coffeeBean.isBOTD {
                    BOTDBadge()
                }
            }
            Text(coffeeBean.country)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            Text(coffeeBean.colour.capitalized)
                .font(.caption)
        }
    }
    
    private var beanCost: some View {
        
        Text(coffeeBean.cost)
            .font(.subheadline.weight(.semibold))
            .foregroundStyle(.primary)
    }
    
}

// MARK: - BOTDBadge

struct BOTDBadge: View {
    var body: some View {
        Label("BOTD", systemImage: "star.fill")
            .font(.caption2.weight(.bold))
            .foregroundStyle(.white)
            .padding(.horizontal, 7)
            .padding(.vertical, 3)
            .background(Color.orange)
            .clipShape(Capsule())
    }
}

#Preview {
    CoffeeBeanListRow(coffeeBean: CoffeeBean.dummy)
}
