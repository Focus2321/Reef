//
//  InstantSwitchModeTests.swift
//  ReefTests
//

import Foundation
import Testing
@testable import Reef

struct InstantSwitchModeTests {
    @Test func defaultsToNever() {
        let suiteName = "InstantSwitchModeTests.defaults"
        let defaults = UserDefaults(suiteName: suiteName)!
        defaults.removePersistentDomain(forName: suiteName)

        #expect(InstantSwitchMode.stored(in: defaults) == .never)
    }

    @Test func readsPersistedValue() {
        let suiteName = "InstantSwitchModeTests.persisted"
        let defaults = UserDefaults(suiteName: suiteName)!
        defaults.removePersistentDomain(forName: suiteName)
        defaults.set(InstantSwitchMode.always.rawValue, forKey: InstantSwitchMode.defaultsKey)

        #expect(InstantSwitchMode.stored(in: defaults) == .always)
    }

    @Test func invalidPersistedValueFallsBackToNever() {
        let suiteName = "InstantSwitchModeTests.invalid"
        let defaults = UserDefaults(suiteName: suiteName)!
        defaults.removePersistentDomain(forName: suiteName)
        defaults.set("invalid", forKey: InstantSwitchMode.defaultsKey)

        #expect(InstantSwitchMode.stored(in: defaults) == .never)
    }

    @Test func directSwitchStartsAtFirstWindow() {
        let index = CyclePanelState.nextWindowIndex(
            windowIDs: [10, 20, 30],
            focusedWindowID: nil
        )

        #expect(index == 0)
    }

    @Test func directSwitchAdvancesFromFocusedWindowID() {
        let index = CyclePanelState.nextWindowIndex(
            windowIDs: [10, 20, 30],
            focusedWindowID: 20
        )

        #expect(index == 2)
    }

    @Test func directSwitchWrapsFromFocusedWindowID() {
        let index = CyclePanelState.nextWindowIndex(
            windowIDs: [10, 20, 30],
            focusedWindowID: 30
        )

        #expect(index == 0)
    }
}
