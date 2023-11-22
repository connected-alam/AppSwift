//
//  AppetizerDetailViewSnapshotTests.swift
//  AppetizersSwiftUITests
//
//  Created by Anders Lam on 2023-11-21.
//

import Foundation
import SwiftUI
import SnapshotTesting
import XCTest

@testable import AppetizersSwiftUI

class AppetizerDetailViewSnapshotTests: SnapshotTestCase {

    var subject: AppetizerDetailView!
    var navigationController: UINavigationController!

    override func setUp() {
        subject = AppetizerDetailView(appetizer: MockData.sampleAppetizer, isShowingDetail: .constant(true))
        navigationController = UINavigationController()
        super.setUp()
    }

    override func tearDown() {
        subject = nil
        super.tearDown()
    }

    func testAppetizerDetailView() {
        let host = UIHostingController(rootView: subject)
        navigationController.pushViewController(host, animated: false)

        let result = verifySnapshot(
            matching: navigationController, 
            as: .image,
            named: "sample",
            testName: "AppetizerDetailView"
        )

        XCTAssertNil(result)
    }
}
