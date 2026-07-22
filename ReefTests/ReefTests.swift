//
//  ReefTests.swift
//  ReefTests
//
//  Created by Xander Gouws on 12-09-2025.
//

import Testing
import AppKit
@testable import Reef

struct ReefTests {

    @Test func example() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    }

    @MainActor
    @Test func closeSelectedWindowKeyDownRequiresWWithoutRepeat() throws {
        let wKeyDown = try #require(keyDownEvent(keyCode: 13))
        let repeatedWKeyDown = try #require(keyDownEvent(keyCode: 13, isARepeat: true))
        let otherKeyDown = try #require(keyDownEvent(keyCode: 12))

        #expect(CyclePanelController.isCloseSelectedWindowEvent(wKeyDown))
        #expect(!CyclePanelController.isCloseSelectedWindowEvent(repeatedWKeyDown))
        #expect(!CyclePanelController.isCloseSelectedWindowEvent(otherKeyDown))
    }

    private func keyDownEvent(keyCode: UInt16, isARepeat: Bool = false) -> NSEvent? {
        NSEvent.keyEvent(
            with: .keyDown,
            location: .zero,
            modifierFlags: [],
            timestamp: 0,
            windowNumber: 0,
            context: nil,
            characters: "w",
            charactersIgnoringModifiers: "w",
            isARepeat: isARepeat,
            keyCode: keyCode
        )
    }

}
