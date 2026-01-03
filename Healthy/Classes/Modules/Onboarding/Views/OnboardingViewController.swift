//
//  OnboardingViewController.swift
//  Healthy
//
//  Created by Aya Mashaly on 02/01/2026.
//

import Foundation
import UIKit
import Lottie

class OnboardingViewController: UIViewController {

    private let animationView = LottieAnimationView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let stackView = UIStackView()
    private let item: OnboardingItem

    init(item: OnboardingItem) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        configure()
    }
}

private extension OnboardingViewController {

    func setupUI() {
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.contentMode = .scaleAspectFit

        titleLabel.applyStyle(style: .screenTitle)
        subtitleLabel.applyStyle(style: .screenSubtitle)

        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false

        stackView.addArrangedSubview(animationView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)

        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),

            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100)
        ])
    }

    func configure() {
        animationView.animation = LottieAnimation.named(item.lottieName)
        animationView.loopMode = .loop
        animationView.play()

        let fullTitle = item.title
        let attributedString = NSMutableAttributedString(string: fullTitle)
        let range1 = (fullTitle as NSString).range(of: "best & Healthy Grocery")
        let range2 = (fullTitle as NSString).range(of: "& Follow Up")
        let range3 = (fullTitle as NSString).range(of: "Let’s Start")
        attributedString.addAttribute(.foregroundColor, value: UIColor.appPrimary, range: range1)
        attributedString.addAttribute(.foregroundColor, value: UIColor.appPrimary, range: range2)
        attributedString.addAttribute(.foregroundColor, value: UIColor.appPrimary, range: range3)
        titleLabel.attributedText = attributedString

        subtitleLabel.text = item.subtitle
    }
}
