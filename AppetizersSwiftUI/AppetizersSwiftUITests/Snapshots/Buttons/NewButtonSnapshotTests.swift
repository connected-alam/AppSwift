//
//  NewButtonSnapshotTests.swift
//  AppetizersSwiftUITests
//
//  Created by Anders Lam on 2023-11-19.
//

import XCTest
import SnapshotTesting

@testable import AppetizersSwiftUI

class NewButtonSnapshotTests: SnapshotTestCase {

    var subject: NewButton!

    override func setUp() {
        subject = NewButton(frame: .init(x: 0, y: 0, width: 128, height: 48))
        super.setUp()
    }

    override func tearDown() {
        subject = nil
        super.tearDown()
    }

    func testNewButtonDefaultState() {
        subject.setTitle("New Login", for: .normal)
        let result = verifySnapshot(of: subject,
                                    as: .image,
                                    named: "DefaultState",
                                    record: false,
                                    testName: "NewButton"
        )


        XCTAssertNil(result)
    }

    func testNewButtonLoadingState() {
        subject.setTitle("New Login", for: .normal)
        subject.isLoading = true
        let result = verifySnapshot(matching: subject,
                                    as: .image,
                                    named: "Loading",
                                    record: false,
                                    testName: "Button")

        XCTAssertNil(result)

    }
}
