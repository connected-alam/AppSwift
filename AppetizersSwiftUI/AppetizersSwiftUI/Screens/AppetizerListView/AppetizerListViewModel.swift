//
//  AppetizerListViewModel.swift
//  AppetizersSwiftUI
//
//  Created by Anders Lam on 2023-05-24.
//

import SwiftUI
import UIKit

final class AppetizerListViewModel: ObservableObject {

    @Published var appetizers: [Appetizer] = []
    @Published var alertItem: AlertItem?
    @Published var isLoading = false
    @Published var isShowingDetail = false
    @Published var selectedAppetizer: Appetizer?

    @MainActor
    func getAppetizers() {
        isLoading = true

        Task {
            do {
                appetizers = try await NetworkManager.shared.getAppetizers()
                isLoading = false
            } catch {
                if let apError = error as? APError {
                    switch apError {
                    case .invalidURL:
                        alertItem = AlertContext.invalidURL
                    case .invalidResponse:
                        alertItem = AlertContext.invalidResponse
                    case .invalidData:
                        alertItem = AlertContext.invalidData
                    case .unableToComplete:
                        alertItem = AlertContext.unableToComplete
                    }
                } else {
                    alertItem = AlertContext.invalidResponse
                }
                isLoading = true
            }
        }
    }

    func getMockAppetizers() {
        let mockAppetizers = [
            Appetizer.init(id: 1, name: "Asian Flank Stank", description: "steak", price: 99.99, imageURL: "https://picsum.photos/200/300", calories: 11, protein: 11, carbs: 11),
            Appetizer.init(id: 2, name: "Coffee", description: "steak", price: 53, imageURL: "https://picsum.photos/200/300", calories: 300, protein: 421, carbs: 200),
            Appetizer.init(id: 2, name: "Random Foods", description: "steak", price: 62, imageURL: "https://picsum.photos/200/300", calories: 121, protein: 81, carbs: 51),
            Appetizer.init(id: 2, name: "Random image", description: "steak", price: 95, imageURL: "https://picsum.photos/200/300", calories: 100, protein: 100, carbs: 600)
        ]
        appetizers = mockAppetizers
    }

    @MainActor 
    static func makeViewModel(isLoading: Bool, isShowingDetail: Bool) -> AppetizerListViewModel {
        let viewModel = AppetizerListViewModel()
        
        viewModel.getMockAppetizers()
        viewModel.isShowingDetail = isShowingDetail
        viewModel.isLoading = isLoading

        if viewModel.isLoading {
            viewModel.appetizers.removeAll()
        }

        if viewModel.isShowingDetail {
            viewModel.selectedAppetizer = viewModel.appetizers.first
        }
        return viewModel
    }

//    func getAppetizers() {
//        isLoading = true
//        NetworkManager.shared.getAppetizers { [self] result in
//            DispatchQueue.main.async {
//                self.isLoading = false
//                switch result {
//                case .success(let appetizers):
//                    self.appetizers = appetizers
//                case .failure(let error):
//                    switch error {
//                    case .invalidResponse:
//                        self.alertItem = AlertContext.invalidResponse
//                    case .invalidURL:
//                        self.alertItem = AlertContext.invalidURL
//                    case .invalidData:
//                        self.alertItem = AlertContext.invalidData
//                    case .unableToComplete:
//                        self.alertItem = AlertContext.unableToComplete
//                    }
//                }
//            }
//        }
//    }

}
