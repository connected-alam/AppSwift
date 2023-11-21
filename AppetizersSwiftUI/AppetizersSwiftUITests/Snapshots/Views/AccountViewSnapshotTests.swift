//
//  AccountViewSnapshotTests.swift
//  AppetizersSwiftUITests
//
//  Created by Anders Lam on 2023-11-20.
//

import Foundation
import SwiftUI
import XCTest
import SnapshotTesting

@testable import AppetizersSwiftUI

class AccountViewSnapshotTests: SnapshotTestCase {

    var subject: AccountView!
    var navigationController: UINavigationController!

    override func setUp() {
        subject = AccountView()
        navigationController = UINavigationController()
        super.setUp()
    }

    override func tearDown() {
        subject = nil
        super.tearDown()
    }
//
//    public let devices: [String: ViewImageConfig] = ["iPhone13ProMax": .iPhone13ProMax,
//                                              "iPhone13Mini": .iPhone13Mini,
//                                              "iPhoneSe": .iPhoneSe]
//
//    public func assertMultipleSnapshot(
//        matching value: UIViewController,
//        named name: String? = nil,
//        record recording: Bool = isRecording,
//        file: StaticString = #file,
//        testName: String = #function
//    ) {
//        devices.map { device in
//            verifySnapshot(matching: value,
//                           as: .image(on: device.value),
//                           named: "\(device.key)",
//                           testName: testName
//            )
//        }
//    }
//
//    func testDefaultAccountView() {
//        let host = UIHostingController(rootView: subject)
//        navigationController.pushViewController(host, animated: false)
//        assertMultipleSnapshot(matching: navigationController)
//    }

    func testCompletedAccountView() {
        let viewModel = AccountViewModel()
        viewModel.user.firstName = "Anders"
        viewModel.user.lastName = "Lam"

        subject = AccountView(viewModel: viewModel)

        let host = UIHostingController(rootView: subject)
        navigationController.pushViewController(host, animated: false)
        assertSnapshot(matching: navigationController, as: uiViewControllerStrategy)
    }
}
