//
//  APButtonSnapshotTests.swift
//  AppetizersSwiftUITests
//
//  Created by Anders Lam on 2023-11-20.
//

import Foundation
import SwiftUI

@testable import AppetizersSwiftUI

class APButtonSnapshotTests: SnapshotTestCase {

    var subject: APButton!
    var navigationController: UINavigationController!

    override func setUp() {
        subject = APButton(title: "Testing")
        navigationController = UINavigationController()
        super.setUp()
    }

    override func tearDown() {
        subject = nil
        navigationController = nil
        super.tearDown()
    }

    func testAPButtonDefaultState() {
        let host = UIHostingController(rootView: subject)
        navigationController.pushViewController(host, animated: false)
        assertSnapshot(matching: navigationController, as: uiViewControllerStrategy)
    }
}
