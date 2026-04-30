//
//  CoffeeConnectContentView.swift
//  CoffeeConnect
//
//  Created by Rajshri Kosurkar on 30/04/26.
//

import SwiftUI

struct CoffeeConnectContentView: View {
    
    @State var coffeeBeanListViewModel: CoffeeBeanListViewModel = CoffeeBeanListViewModel()
    
    var body: some View {
        CoffeeBeanListView(viewModel: coffeeBeanListViewModel)
    }
}

#Preview {
    CoffeeConnectContentView()
}
