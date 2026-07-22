//
//  CyclePanelStateTests.swift
//  ReefTests
//

import Testing
@testable import Reef

@MainActor
struct CyclePanelStateTests {
    private func makeState(itemCount: Int) -> CyclePanelState {
        let state = CyclePanelState()
        state.items = Array(repeating: .action(.openWindow), count: itemCount)
        return state
    }

    @Test func cyclePreviousDoesNothingWhenEmpty() {
        let state = makeState(itemCount: 0)

        state.cyclePrevious()

        #expect(state.selectedIndex == 0)
    }

    @Test func cyclePreviousWrapsFromFirstToLast() {
        let state = makeState(itemCount: 3)

        state.cyclePrevious()

        #expect(state.selectedIndex == 2)
    }

    @Test func cyclePreviousMovesBackOneItem() {
        let state = makeState(itemCount: 3)
        state.selectedIndex = 2

        state.cyclePrevious()

        #expect(state.selectedIndex == 1)
    }
}
