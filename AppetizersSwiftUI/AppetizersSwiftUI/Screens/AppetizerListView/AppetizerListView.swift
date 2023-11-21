//
//  AppetizerListView.swift
//  AppetizersSwiftUI
//
//  Created by Anders Lam on 2022-10-05.
//

import SwiftUI
import PreviewSnapshots

struct AppetizerListView: View {

    @StateObject var viewModel = AppetizerListViewModel()

    var body: some View {
        ZStack {
            NavigationView {
                List(viewModel.appetizers) { appetizer in
                    AppetizerListCell(appetizer: appetizer)
                        .listRowSeparator(.hidden)
                        .onTapGesture {
                            viewModel.selectedAppetizer = appetizer
                            viewModel.isShowingDetail = true
                        }
                }
                .navigationTitle("Appetizers")
                .listStyle(.plain)
                .disabled(viewModel.isShowingDetail)
            }
            .task {
                viewModel.getAppetizers()
            }
            .blur(radius: viewModel.isShowingDetail ? 20 : 0)

            if viewModel.isShowingDetail {
                AppetizerDetailView(appetizer: viewModel.selectedAppetizer!, isShowingDetail: $viewModel.isShowingDetail)
            }

            if viewModel.isLoading {
                LoadingView()
            }
        }
        .alert(item: $viewModel.alertItem) { alert in
            Alert(title: alert.title, message: alert.message, dismissButton: alert.dismissButton)
        }
    }
}

struct AppetizerListView_Previews: PreviewProvider {
    static var previews: some View {
        snapshots.previews
    }

    static var snapshots: PreviewSnapshots<State> {
        PreviewSnapshots(
            states: [
                .init(
                    name: "Loading State",
                    viewModel: AppetizerListViewModel.makeViewModel(isLoading: true, isShowingDetail: false)
                 ),
                .init(
                    name: "Loaded State",
                    viewModel: AppetizerListViewModel.makeViewModel(isLoading: false, isShowingDetail: false)
                ),
                .init(
                    name: "App Detail State",
                    viewModel: AppetizerListViewModel.makeViewModel(isLoading: false, isShowingDetail: true)
                )
            ]
        ) { state in
            return AppetizerListView(viewModel: state.viewModel)
        }
    }

    struct State: NamedPreviewState {
        var name: String
        var viewModel: AppetizerListViewModel
    }
}
