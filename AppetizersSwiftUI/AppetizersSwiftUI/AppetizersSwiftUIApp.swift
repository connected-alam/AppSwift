//
//  AppetizersSwiftUIApp.swift
//  AppetizersSwiftUI
//
//  Created by Anders Lam on 2022-10-03.
//

import SwiftUI

@main
struct AppetizersSwiftUIApp: App {

    var order = Order()

    var body: some Scene {
        WindowGroup {
            AppetizerTabView().environmentObject(order)
        }
    }
}
