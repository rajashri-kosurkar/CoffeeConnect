//
//  CoffeeBean.swift
//  CoffeeConnect
//
//  Created by Rajshri Kosurkar on 30/04/26.
//

import Foundation

/*
 "_id": "66a374596122a40616cb8599",
 "index": 0,
 "isBOTD": false,
 "Cost": "£39.26",
 "Image": "https://images.unsplash.com/photo-1672306319681-7b6d7ef349cf",
 "colour": "dark roast",
 "Name": "TURNABOUT",
 "Description": "Ipsum cupidatat nisi do elit veniam Lorem magna. Ullamco qui exercitation fugiat pariatur sunt dolore Lorem magna magna pariatur minim. Officia amet incididunt ad proident. Dolore est irure ex fugiat. Voluptate sunt qui ut irure commodo excepteur enim labore incididunt quis duis. Velit anim amet tempor ut labore sint deserunt.\r\n",
 "Country": "Peru"
 */

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
       
       static var dummy : CoffeeBean {
           return CoffeeBean(id:"66a374596122a40616cb8599",
                             index: 0,
                             isBOTD: true,
                             cost: "£39.26",
                             imageURL: "https://images.unsplash.com/photo-1672306319681-7b6d7ef349cf",
                             colour: "dark roast",
                             name: "TURNABOUT",
                             description: "Ipsum cupidatat nisi do elit veniam Lorem magna. Ullamco qui exercitation fugiat pariatur sunt dolore Lorem magna magna pariatur minim. Officia amet incididunt ad proident. Dolore est irure ex fugiat. Voluptate sunt qui ut irure commodo excepteur enim labore incididunt quis duis. Velit anim amet tempor ut labore sint deserunt.\r\n",
                             country: "Peru")
       }
}
