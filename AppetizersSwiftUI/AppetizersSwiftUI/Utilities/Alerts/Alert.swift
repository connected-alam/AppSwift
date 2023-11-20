//
//  Alert.swift
//  AppetizersSwiftUI
//
//  Created by Anders Lam on 2023-05-24.
//

import Foundation
import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
}

struct AlertContext {

    //MARK - Food alerts
    static let invalidData = AlertItem(title: Text("Server Error"),
                                              message: Text("Invalid Data"),
                                              dismissButton: .default(Text("OK")))

    static let invalidResponse = AlertItem(title: Text("Server Error"),
                                                       message: Text("Invalid Response"),
                                              dismissButton: .default(Text("OK")))

    static let invalidURL = AlertItem(title: Text("Server Error"),
                                              message: Text("invalid URL"),
                                              dismissButton: .default(Text("OK")))

    static let unableToComplete = AlertItem(title: Text("Server Error"),
                                                        message: Text("unable to complete"),
                                              dismissButton: .default(Text("OK")))

    // MARK: - Account Alerts
    static let invalidForm = AlertItem(title: Text("Invalid Form"),
                                                        message: Text("unable to complete"),
                                              dismissButton: .default(Text("OK")))

    static let invalidEmail = AlertItem(title: Text("Invalid Email"),
                                                        message: Text("unable to complete"),
                                              dismissButton: .default(Text("OK")))

    static let userSaveSuccess = AlertItem(title: Text("Profile Saved"),
                                                        message: Text("Profile saved"),
                                              dismissButton: .default(Text("OK")))

    static let userSaveFail = AlertItem(title: Text("Profile save failed"),
                                                        message: Text("Profile did not save"),
                                              dismissButton: .default(Text("OK")))
}
