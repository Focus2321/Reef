//
//  FeedbackPanelController.swift
//  Reef
//

import AppKit

@MainActor
final class FeedbackPanelController {
    private let panel: CyclePanel
    private let iconView = NSImageView()
    private let titleLabel = NSTextField(labelWithString: "")
    private let messageLabel = NSTextField(labelWithString: "")
    private var hideTask: Task<Void, Never>?

    init() {
        panel = CyclePanel(contentRect: NSRect(x: 0, y: 0, width: 400, height: 76))
        panel.hidesOnDeactivate = false
        panel.ignoresMouseEvents = true

        iconView.image = NSApp.applicationIconImage
        iconView.imageScaling = .scaleProportionallyUpOrDown
        iconView.setAccessibilityElement(false)

        titleLabel.stringValue = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? "Reef"
        titleLabel.font = .systemFont(ofSize: 11, weight: .semibold)
        titleLabel.textColor = NSColor.white.withAlphaComponent(0.7)
        titleLabel.lineBreakMode = .byTruncatingTail

        messageLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        messageLabel.textColor = .white
        messageLabel.lineBreakMode = .byTruncatingTail

        let textStack = NSStackView(views: [titleLabel, messageLabel])
        textStack.orientation = .vertical
        textStack.alignment = .leading
        textStack.spacing = 2

        let contentStack = NSStackView(views: [iconView, textStack])
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
            iconView.widthAnchor.constraint(equalToConstant: 36),
            iconView.heightAnchor.constraint(equalToConstant: 36)
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
