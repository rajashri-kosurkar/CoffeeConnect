//
//  BeanOfTheDayView.swift
//  CoffeeConnect
//
//  Created by Rajshri Kosurkar on 05/05/26.
//

import SwiftUI

struct BeanOfTheDayView: View {
    // MARK: - Properties
    // Optional CoffeeBean — can be nil when:
    // • Data is still loading from service
    // • No bean is marked isBOTD in the JSON
    // • Network/file error occurred before data arrived
    let coffeeBean: CoffeeBean?
    
    @State private var showDetail = false
    
    // MARK: - Body
    // Switches between three states based on 'coffeeBean'
    var body: some View {
        NavigationStack {
            ScrollView {
                if let bean = coffeeBean {
                    // STATE 1: Bean is available — show full content
                    loadBeanOfTheDayView(bean: bean)
                } else {
                    // STATE 2: Bean is nil — show placeholder
                    loadingPlaceholderView
                }
            }
            .navigationTitle("Bean of the Day")
            // Sheet only presented when coffeeBean is non-nil
            // 'if let' inside sheet closure prevents
            // attempting to show detail with nil data
            .sheet(isPresented: $showDetail) {
                if let bean = coffeeBean {
                    NavigationStack {
                        CoffeeBeanDetailView(coffeeBean: bean)
                            .navigationTitle(bean.name)
                    }
                }
            }
        }
    }
}

extension BeanOfTheDayView {
    
    // Main content wrapper — receives unwrapped bean
    private func loadBeanOfTheDayView(bean: CoffeeBean) -> some View {
        VStack {
            beanBackgroundImageWithData(bean: bean)
            VStack(alignment: .leading, spacing: 20) {
                detailSection(bean: bean)
                descriptionSection(bean: bean)
                moreInformationButton
            }
            .padding(25)
        }
    }
    
    // MARK: Image with Overlay Text

    private func beanBackgroundImageWithData(bean: CoffeeBean) -> some View {
        ZStack(alignment: .bottomLeading) {
            // Async image — loads from URL
            AsyncImage(url: URL(string: bean.imageURL)) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                case .failure:
                    // Network failure fallback
                    Color.brown.opacity(0.2)
                        .overlay(
                            Image(systemName: "photo")
                                .font(.largeTitle)
                                .foregroundStyle(.white.opacity(0.6))
                        )
                case .empty:
                    // Loading state
                    ZStack {
                        Color.brown.opacity(0.2)
                        ProgressView().tint(.white)
                    }
                @unknown default:
                    Color.brown.opacity(0.2)
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 320)
            .clipped()
            
            
            // Text overlay on image
            VStack(alignment: .leading, spacing: 8) {
                Label("Bean of the Day", systemImage: "star.fill")
                    .foregroundStyle(.yellow)
                    .font(.subheadline.bold())
                
                Text(bean.name)
                    .font(.title.bold())
                
                Text(bean.country)
                    .font(.subheadline.bold())
            }
            .foregroundStyle(.white)
            .padding()
        }
    }
    
    // MARK: Detail Chips Row
    private func detailSection(bean: CoffeeBean) -> some View {
        HStack {
            DetailView(
                icon: "tag.fill",
                title: bean.cost,
                value: "Today's Price",
                color: .green.opacity(0.2)
            )
            DetailView(
                icon: "flame",
                title: bean.colour,
                value: "Roast",
                color: .brown.opacity(0.2)
            )
            DetailView(
                icon: "globe",
                title: bean.country,
                value: "Origin",
                color: .purple.opacity(0.2)
            )
        }
    }
    
    // MARK: Description Section
    private func descriptionSection(bean: CoffeeBean) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Bean Description")
                .font(.headline)
            Text(bean.description
                .trimmingCharacters(in: .whitespacesAndNewlines))
            .font(.body)
            .foregroundStyle(.secondary)
        }
    }
    
    // MARK: More Information Button
    // Only tappable when bean is non-nil
    // Button is not shown at all in loading state
    private var moreInformationButton: some View {
        Button {
            showDetail = true
        } label: {
            HStack {
                Image(systemName: "info.circle.fill")
                Text("More Information")
                Spacer()
                Image(systemName: "chevron.right")
            }
            .padding()
            .background(.tertiary)
            .clipShape(RoundedRectangle(cornerRadius: 14))
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Loaded State Subviews
// Only rendered when bean is non-nil
// All subviews receive a non-optional CoffeeBean
// No force unwrapping needed anywhere

// MARK: - Loading / Nil State
// Shown when bean == nil
// Displays a friendly placeholder while data loads
// or when no BOTD bean exists in the dataset
 
extension BeanOfTheDayView {
    
    private var loadingPlaceholderView: some View {
        VStack(spacing: 24) {
            Spacer(minLength: 60)
            
            // Animated coffee cup icon
            Image(systemName: "cup.and.saucer.fill")
                .font(.system(size: 64))
                .foregroundStyle(.brown.opacity(0.2))
            
            VStack(spacing: 8) {
                Text("Finding Today's Bean...")
                    .font(.title3.weight(.semibold))
                    .foregroundStyle(.primary)
                
                Text("Our team is selecting the perfect\nbean for today. Check back soon!")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
            }
            
            ProgressView()
                .padding(.top, 8)
            
            Spacer(minLength: 60)
        }
        .frame(maxWidth: .infinity)
        .frame(minHeight: 400)
    }
}

// Preview 1: Bean loaded — primary happy path
#Preview("Bean Loaded") {
    BeanOfTheDayView(coffeeBean: CoffeeBean.mockBOTD)
}
 
// Preview 2: nil bean — loading/placeholder state
// Simulates the state between app launch and data load
#Preview("Loading - nil bean") {
    BeanOfTheDayView(coffeeBean: nil)
}
