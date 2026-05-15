//
//  CoffeeBean.swift
//  CoffeeConnect
//
//  Created by Rajshri Kosurkar on 30/04/26.
//

import Foundation

struct CoffeeBean: Identifiable, Codable {
    
    let id: String
    let index: Int
    let isBOTD: Bool
    let cost: String
    let imageURL: String
    let colour: String
    let name: String
    let description: String
    let country: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case index
        case isBOTD
        case cost = "Cost"
        case imageURL = "Image"
        case colour
        case name = "Name"
        case description = "Description"
        case country = "Country"
    }
    
    var costValue: Double? {
        return Double(cost.replacingOccurrences(of: "£", with: ""))
    }
    
}

extension CoffeeBean {
    
    static let mockBeans: [CoffeeBean] = [
        CoffeeBean(
            id: "66a37459771606d916a226ff",
            index: 3,
            isBOTD: true,
            cost: "£17.69",
            imageURL: "https://images.unsplash.com/photo-1598198192305-46b0805890d3",
            colour: "dark roast",
            name: "RONBERT",
            description: "Et deserunt nisi in anim cillum sint voluptate proident. Est occaecat id cupidatat cupidatat ex veniam irure veniam pariatur excepteur duis labore occaecat amet.",
            country: "Brazil"
        ),
        CoffeeBean(
            id: "66a3745945fcae53593c42e7",
            index: 4,
            isBOTD: false,
            cost: "£26.53",
            imageURL: "https://images.unsplash.com/photo-1512568400610-62da28bc8a13",
            colour: "green",
            name: "EARWAX",
            description: "Labore veniam amet ipsum eu dolor. Aliquip Lorem et eiusmod exercitation.",
            country: "Vietnam"
        ),
        CoffeeBean(
            id: "66a374593a88b14d9fff0e2e",
            index: 9,
            isBOTD: false,
            cost: "£25.49",
            imageURL: "https://images.unsplash.com/photo-1549420751-ea3f7ab42006",
            colour: "green",
            name: "LOCAZONE",
            description: "Deserunt consequat ea incididunt aliquip. Occaecat excepteur minim occaecat aute amet adipisicing.",
            country: "Vietnam"
        )
    ]
    
    static let mockBOTD: CoffeeBean = mockBeans.first(where: { $0.isBOTD }) ?? mockBeans[0]
    
}
