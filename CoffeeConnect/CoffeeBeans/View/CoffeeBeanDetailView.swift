//
//  CoffeeBeanDetailView.swift
//  CoffeeConnect
//
//  Created by Rajshri Kosurkar on 30/04/26.
//

import SwiftUI

struct CoffeeBeanDetailView: View {
    
    let coffeeBean: CoffeeBean
    @State private var showOrderForm = false
    
    var body: some View {
        ScrollView {
            VStack {
                beanBackgroundImage
                VStack(alignment: .leading, spacing: 20) {
                    headerSection
                    Divider()
                    detailSection
                    Divider()
                    descriptionSection
                    ordenNowButton
                }
                .padding(20)
            }
        }
        .sheet(isPresented: $showOrderForm) {
            OrderFormView(orderFormViewModel: OrderFormViewModel(coffeeBean: coffeeBean))
        }
        .navigationTitle(coffeeBean.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

extension CoffeeBeanDetailView {
    
    // MARK: Subviews
    
    private var beanBackgroundImage: some View {
        AsyncImage(url: URL(string: coffeeBean.imageURL)) { image in
            image
                .resizable()
                .scaledToFill()
        } placeholder: {
            ZStack {
                Color.brown.opacity(0.2)
                ProgressView()
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 280)
        .clipped()
    }
    
    private var headerSection: some View {
        HStack(alignment: .top) {
            
            VStack(alignment: .leading, spacing: 6) {
                
                HStack {
                    Text(coffeeBean.name)
                        .font(.title.bold())
                    if coffeeBean.isBOTD{
                        BOTDBadge()
                    }
                }
                
                Text(coffeeBean.country)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Text(coffeeBean.cost)
                .font(.title2.weight(.bold))
        }
    }
    
    private var detailSection: some View {
        
        HStack {
            DetailView(icon: "flame", title: coffeeBean.colour, value: "Roast", color: .brown.opacity(0.2))
            DetailView(icon: "globe", title: coffeeBean.country, value: "Origin", color: .purple.opacity(0.2))
            DetailView(icon: "number", title:"\(coffeeBean.index)", value: "Index", color: .green.opacity(0.2))
        }
    }
    
    private var descriptionSection: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            Text("About this Bean")
                .font(.headline)
            Text(coffeeBean.description)
                .font(.body)
                .foregroundStyle(.secondary)
        }
        
    }
    private var ordenNowButton:some View {
        Button {
            showOrderForm = true
        } label: {
            Label("Orden Now", systemImage: "cart.fill")
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .font(.headline.bold())
        }
        .buttonStyle(.borderedProminent)
    }
}

struct DetailView: View {
    var icon: String
    var title: String
    var value: String
    var color: Color
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(color)
            .frame(height: 100)
            .frame(maxWidth: .infinity)
            .overlay {
                VStack(spacing: 6) {
                    Image(systemName: icon)
                    Text(title.capitalized)
                        .font(.footnote.bold())
                        .foregroundColor(.black)
                    Text(value)
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
               
            }
    }
}

#Preview {
    NavigationStack {
        CoffeeBeanDetailView(coffeeBean: CoffeeBean.dummy)
    }
}
