//
//  Order.swift
//  AppetizersSwiftUI
//
//  Created by Anders Lam on 2023-05-30.
//

import SwiftUI

final class Order: ObservableObject {

    @Published var items: [Appetizer] = []

    var totalPrice: Double {
        items.reduce(0) { $0 + $1.price }
    }

    func add(_ appetizer: Appetizer) {
        items.append(appetizer)
    }

    func deleteItems(at offset: IndexSet) {
         items.remove(atOffsets: offset)
    }
}
