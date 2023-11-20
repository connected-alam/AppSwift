//
//  APError.swift
//  AppetizersSwiftUI
//
//  Created by Anders Lam on 2023-05-24.
//

import Foundation

enum APError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case unableToComplete
}
