//
//  FeedbackPanelController.swift
//  Reef
//

import AppKit

@MainActor
final class FeedbackPanelController {
    private let panel: CyclePanel
    private let messageLabel = NSTextField(labelWithString: "")
    private var hideTask: Task<Void, Never>?

    init() {
        panel = CyclePanel(contentRect: NSRect(x: 0, y: 0, width: 400, height: 64))
        panel.hidesOnDeactivate = false
        panel.ignoresMouseEvents = true

        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.alignment = .center
        messageLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        messageLabel.textColor = .white
        messageLabel.lineBreakMode = .byTruncatingTail

        guard let contentView = panel.contentView else { return }
        contentView.addSubview(messageLabel)
        NSLayoutConstraint.activate([
            messageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            messageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            messageLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    func show(_ message: String) {
        hideTask?.cancel()
        messageLabel.stringValue = message
        panel.center()
        panel.orderFrontRegardless()

        hideTask = Task { [weak self] in
            do {
                try await Task.sleep(nanoseconds: 1_500_000_000)
            } catch {
                return
            }

            self?.panel.orderOut(nil)
        }
    }
}
