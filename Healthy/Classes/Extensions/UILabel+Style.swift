//
//  UILabel+Style.swift
//  Healthy
//
//  Created by Aya Mashaly on 02/01/2026.
//

import Foundation
import UIKit

extension UILabel {

    // MARK: Style

    enum LabelStyle {
        case screenTitle
        case screenSubtitle
        case sectionDescription
        case fieldTitle
    }

    // MARK: Apply Style

    func applyStyle(style: LabelStyle) {
        switch style {
        case .screenTitle:
            applyScreenTitleStyle()
        case .screenSubtitle:
            applyScreenSubtitleStyle()
        case .sectionDescription:
            applySectionDescriptionStyle()
        case .fieldTitle:
            applyFieldTitleStyle()
        }
    }

    // MARK: Individual Style Functions

    private func applyScreenTitleStyle() {
        font = .boldSystemFont(ofSize: 24)
        textColor = .black
        numberOfLines = 0
        textAlignment = .center
    }

    private func applyScreenSubtitleStyle() {
        font = .systemFont(ofSize: 18)
        textColor = .darkGray
        numberOfLines = 0
        textAlignment = .center
    }

    private func applySectionDescriptionStyle() {
        font = .systemFont(ofSize: 14)
        textColor = .gray
        numberOfLines = 0
        textAlignment = .center
    }

    private func applyFieldTitleStyle() {
        font = .systemFont(ofSize: 13)
        textColor = .lightGray
        numberOfLines = 1
        textAlignment = .left
    }
}
