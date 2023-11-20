//
//  User.swift
//  AppetizersSwiftUI
//
//  Created by Anders Lam on 2023-05-29.
//

import Foundation

struct User: Codable {
    var firstName = ""
    var lastName = ""
    var email = ""
    var birthdate = Date()
    var extraNapkins = false
    var frequentRefills = false
}
