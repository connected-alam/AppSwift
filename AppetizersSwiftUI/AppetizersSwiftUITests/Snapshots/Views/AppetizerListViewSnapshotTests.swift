//
//  AppetizerListViewSnapshotTests.swift
//  AppetizersSwiftUITests
//
//  Created by Anders Lam on 2023-11-20.
//

import Foundation
import SwiftUI
import PreviewSnapshotsTesting

@testable import AppetizersSwiftUI

class AppetizerListViewSnapshotTests: SnapshotTestCase {

    var subject: AppetizerListView!
    var navigationController: UINavigationController!
    var viewModel: AppetizerListViewModel!

    override func setUp() {
        subject = AppetizerListView()
        navigationController = UINavigationController()
        viewModel = AppetizerListViewModel()
        super.setUp()
    }

    override func tearDown() {
        subject = nil
        navigationController = nil
        viewModel = nil
        super.tearDown()
    }

    @MainActor 
    func testAppetizerListView() {
        viewModel.getMockAppetizers()
        subject = AppetizerListView(viewModel: self.viewModel)
        let host = UIHostingController(rootView: subject)
        
        navigationController.pushViewController(host, animated: false)
        assertSnapshot(matching: navigationController, as: uiViewControllerStrategy)
    }

    func testAppetizerListViewPreviews() {
//        AppetizerListView_Previews.snapshots.assertSnapshots()
        assertPreviewSnapshots(AppetizerListView_Previews.snapshots, as: anyDeviceStrategy)
    }
}
