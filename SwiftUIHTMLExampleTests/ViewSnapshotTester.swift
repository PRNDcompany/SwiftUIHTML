//  Copyright © 2025 PRND. All rights reserved.
import SwiftUI
import UIKit

import SnapshotTesting

/// Utility class for rendering SwiftUI views in UIKit environment and generating snapshots
class ViewSnapshotTester {

    @MainActor
    static func snapshot<V: View>(
        of view: V,
        named name: String? = nil,
        record recording: Bool? = nil,
        sleep sleepDuration: Duration = .seconds(2),
        fileID: StaticString = #fileID,
        file filePath: StaticString = #filePath,
        testName: String = #function,
        line: UInt = #line,
        column: UInt = #column
    ) async throws {
        // Wrap SwiftUI view as UIKit view
        let rootView = view.background(Color.white).compositingGroup().ignoresSafeArea()
        let hostingView = UIHostingController(rootView: rootView).view!

        // Create container view controller
        let viewController = UIViewController()
        viewController.view.addSubview(hostingView)
        
        // Setup auto layout
        hostingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingView.topAnchor.constraint(equalTo: viewController.view.topAnchor),
            hostingView.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor)
        ])

        // Create and display window
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        
        // Wait for layout calculation time
        try await Task.sleep(for: sleepDuration)

        // Force layout update
        await MainActor.run {
            viewController.view.layoutIfNeeded()
            viewController.view.setNeedsLayout()
            hostingView.invalidateIntrinsicContentSize()
        }
        
        // Find rendered view
        guard let renderedView = findActualRenderedView(in: hostingView) else {
            throw SnapshotError.viewNotFound
        }

        assertSnapshot(
            of: renderedView,
            as: .image,// (traits: .init(displayScale: 1))
            named: name,
            record: recording,
            fileID: fileID,
            file: filePath,
            testName: testName,
            line: line,
            column: column
        )
    }

    /// Snapshot error type
    enum SnapshotError: Error {
        case viewNotFound
    }
    
    /// Find actual rendered view 
    private static func findActualRenderedView(in hostingView: UIView) -> UIView? {
        // Find the actual rendered view inside UIHostingView
        // Usually the first child view or may vary depending on specific hierarchy structure
        if let contentView = hostingView.subviews.first {
            return contentView
        }
        return hostingView
    }
}
