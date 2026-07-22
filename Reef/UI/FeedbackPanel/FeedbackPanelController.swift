//
//  FeedbackPanelController.swift
//  Reef
//

import AppKit

@MainActor
final class FeedbackPanelController {
    private let panel: CyclePanel
    private let iconView = NSImageView()
    private let messageLabel = NSTextField(labelWithString: "")
    private var hideTask: Task<Void, Never>?

    init() {
        panel = CyclePanel(contentRect: NSRect(x: 0, y: 0, width: 400, height: 64))
        panel.hidesOnDeactivate = false
        panel.ignoresMouseEvents = true

        iconView.imageScaling = .scaleProportionallyUpOrDown
        iconView.setAccessibilityElement(false)

        messageLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        messageLabel.textColor = .white
        messageLabel.lineBreakMode = .byTruncatingTail

        let contentStack = NSStackView(views: [iconView, messageLabel])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.orientation = .horizontal
        contentStack.alignment = .centerY
        contentStack.spacing = 12

        guard let contentView = panel.contentView else { return }
        contentView.addSubview(contentStack)
        NSLayoutConstraint.activate([
            contentStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            contentStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            contentStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 32),
            iconView.heightAnchor.constraint(equalToConstant: 32)
        ])
    }

    func show(_ message: String, icon: NSImage? = nil) {
        hideTask?.cancel()
        iconView.image = icon
        iconView.isHidden = icon == nil
        messageLabel.stringValue = message
        messageLabel.alignment = icon == nil ? .center : .left
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
