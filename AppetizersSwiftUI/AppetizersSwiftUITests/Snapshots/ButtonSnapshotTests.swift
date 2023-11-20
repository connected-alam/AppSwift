//
//  ButtonSnapshotTests.swift
//  AppetizersSwiftUITests
//
//  Created by Anders Lam on 2023-11-19.
//

import XCTest
import SnapshotTesting

@testable import AppetizersSwiftUI

class ButtonSnapshotTests: XCTestCase {

    func test_buttonDefaultState() {
          let button = NewButton(frame: .init(x: 0, y: 0, width: 128, height: 48)) // 1
          button.setTitle("Login", for: .normal) // 2
          let result = verifySnapshot(matching: button,  // 3
                                      as: .image, // 4
                                      named: "Default", // 5
                                      testName: "Button") // 6


          XCTAssertNil(result) // 7
      }
}
