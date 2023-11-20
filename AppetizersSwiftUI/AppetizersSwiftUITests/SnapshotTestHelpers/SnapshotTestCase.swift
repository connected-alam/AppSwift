//
//  SnapshotTestCase.swift
//  AppetizersSwiftUITests
//
//  Created by Anders Lam on 2023-11-20.
//


import Foundation
import SnapshotTesting
import SwiftUI
import XCTest

private extension String {
    static let iPhone13Mini = "iPhone13Mini"
    static let iPhoneSe = "iPhoneSe"
    static let iPhone13ProMax = "iPhone13ProMax"
}

// MARK: - SnapshotTestCase

open class SnapshotTestCase: XCTestCase {

    public typealias FilenameExtension = String
    public var perceptualPrecision: Float = 0.98
    static let snapshotsFolder = "/Snapshots/"

    let devices: [String: ViewImageConfig] = ["iPhone13ProMax": .iPhone13ProMax,
                                              "iPhone13Mini": .iPhone13Mini,
                                              "iPhoneSe": .iPhoneSe]

    public func assertMultipleSnapshot(
        matching value: UIViewController,
        named name: String? = nil,
        record recording: Bool = isRecording,
        file: StaticString = #file,
        testName: String = #function
    ) {
        let results = devices.map { device in
            verifySnapshot(matching: value,
                           as: .image(on: device.value),
                           named: "\(device.key)",
                           testName: testName
            )
        }

        results.forEach { XCTAssertNil($0) }
    }

    /// snapshot variants for UIViewControllerStrategy
    public var uiViewControllerStrategy: [(Snapshotting<UIViewController, UIImage>, FilenameExtension)] {
        [
            (
                .image(
                    on: .iPhone13Mini,
                    perceptualPrecision: perceptualPrecision,
                    traits: .init(userInterfaceStyle: .light)
                ),
                .iPhone13Mini
            ),
            (
                .image(
                    on: .iPhoneSe,
                    perceptualPrecision: perceptualPrecision,
                    traits: .init(userInterfaceStyle: .dark)
                ),
                .iPhoneSe
            ),
            (
                .image(
                    on: .iPhone13ProMax,
                    perceptualPrecision: perceptualPrecision,
                    traits: .init(userInterfaceStyle: .light)
                ),
                .iPhone13ProMax
            )

        ]
    }

    public func assertSnapshot<Value, Format>(
        matching value: Value,
        as snapshotting: SnapshotTesting.Snapshotting<Value,Format>,
        named name: String? = nil,
        record recording: Bool = isRecording,
        file: StaticString = #file,
        testName: String = #function,
        line: UInt = #line
    ) {
        let failure = verifySnapshot(
            matching: value,
            as: snapshotting,
            named: name,
            record: recording,
            timeout: 5,
            file: file,
            testName: testName,
            line: line
        )
        guard let message = failure else { return }
        XCTFail(message, file: file, line: line)
    }

    public func assertSnapshot<Value, Format>(
        matching value: Value,
        as snapshotting: [(SnapshotTesting.Snapshotting<Value,Format>, FilenameExtension)],
        record recording: Bool = isRecording,
        file: StaticString = #file,
        testName: String = #function,
        line: UInt = #line
    ) {
        snapshotting.forEach { strategy in
            assertSnapshot(
                matching: value,
                as: strategy.0,
                named: strategy.1,
                record: recording,
                file: file,
                testName: testName,
                line: line
            )
        }
    }
}

extension SwiftUI.View {
    func convertToViewController() -> UIViewController {
        let viewController = UIHostingController(rootView: self)
        viewController.view.frame = UIScreen.main.bounds
        return viewController
    }
}
