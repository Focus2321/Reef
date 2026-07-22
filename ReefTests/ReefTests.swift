//
//  ReefTests.swift
//  ReefTests
//
//  Created by Xander Gouws on 12-09-2025.
//

import Testing
import CoreGraphics
@testable import Reef

struct ReefTests {

    @Test func example() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    }

    @MainActor
    @Test func cyclePanelCentersWithinOffsetVisibleFrame() {
        let visibleFrame = CGRect(x: -1920, y: 25, width: 1920, height: 1055)

        let origin = CyclePanelController.centeredOrigin(
            for: CGSize(width: 400, height: 300),
            in: visibleFrame
        )

        #expect(origin == CGPoint(x: -1160, y: 402.5))
    }

}
