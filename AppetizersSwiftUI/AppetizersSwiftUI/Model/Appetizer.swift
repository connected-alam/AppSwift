//
//  Appetizer.swift
//  AppetizersSwiftUI
//
//  Created by Anders Lam on 2022-10-25.
//

import Foundation

struct Appetizer: Codable, Identifiable {
    let id: Int
    let name: String
    let description: String
    let price: Double
    let imageURL: String
    let calories: Int
    let protein: Int
    let carbs: Int
}

struct AppetizerResponse: Decodable {
    let request: [Appetizer]
}

struct MockData {
    static let sampleAppetizer = Appetizer(id: 0001, name: "Test Appetizer", description: "This is description", price: 9.99, imageURL: "", calories: 99, protein: 99, carbs: 99)
    
    static let appetizers = [sampleAppetizer, sampleAppetizer, sampleAppetizer, sampleAppetizer]

    static let sampleAppetizer2 = Appetizer(id: 0002, name: "Test Appetizer", description: "This is description", price: 9.99, imageURL: "", calories: 99, protein: 99, carbs: 99)

    static let sampleAppetizer3 = Appetizer(id: 0003, name: "Test Appetizer", description: "This is description", price: 9.99, imageURL: "", calories: 99, protein: 99, carbs: 99)

    static let appetizersDiff = [sampleAppetizer, sampleAppetizer2, sampleAppetizer3]
}
