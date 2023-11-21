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
import PreviewSnapshots

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

    public var anyDeviceStrategy: [(Snapshotting<AnyView, UIImage>, FilenameExtension)] {
        [
            (
                .image(
                    layout: .device(config: .iPhone13Mini),
                    traits: .init(userInterfaceStyle: .light)
                ),
                .iPhone13Mini
            ),
            (
                .image(
                    layout: .device(config: .iPhoneSe),
                    traits: .init(userInterfaceStyle: .dark)
                ),
                .iPhoneSe
            ),
            (
                .image(
                    layout: .device(config: .iPhone13ProMax),
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

    func assertPreviewSnapshots<State>(
        _ previewSnapshots: PreviewSnapshots<State>,
        as snapshotting: Snapshotting<AnyView, UIImage>,
        named name: String? = nil,
        record recording: Bool = false,
        testName: String = #function
    ) {
        for configuration in previewSnapshots.configurations {
            var fullName = configuration.name
            if let name {
                fullName.append(".\(name)")
            }

            assertSnapshot(
                matching: previewSnapshots.configure(configuration.state),
                as: snapshotting,
                named: fullName,
                record: recording,
                testName: testName
            )
        }
    }


    public func assertPreviewSnapshots<State>(
        _ previewSnapshots: PreviewSnapshots<State>,
        as stategy: [(SnapshotTesting.Snapshotting<AnyView, UIImage>, FilenameExtension)],
        record recording: Bool = false,
        testName: String = #function
    ) {
        stategy.forEach { snapshotting, filename in
            assertPreviewSnapshots(
                previewSnapshots,
                as: snapshotting,
                named: filename,
                record: recording,
                testName: testName
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
