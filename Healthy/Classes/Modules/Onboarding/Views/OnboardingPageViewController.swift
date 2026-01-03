//
//  OnboardingPageViewController.swift
//  Healthy
//
//  Created by Aya Mashaly on 02/01/2026.
//
import UIKit

class OnboardingPageViewController: UIPageViewController {

    private var pages: [UIViewController] = []
    private let pageControl = UIPageControl()
    private let nextButton = UIButton()
    private let prevButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPages()
        setupPageControl()
        setupNavigationButtons()
        dataSource = self
        delegate = self
    }
}

private extension OnboardingPageViewController {

    func setupPages() {
        let items = [
            OnboardingItem(
                lottieName: "onboarding_order",
                title: "Let’s find the best & Healthy Grocery",
                subtitle: "Shop fresh groceries easily from your home and add your favorites to the cart."
            ),
            OnboardingItem(
                lottieName: "onboarding_lets_cooking",
                title: "Let’s Start Cooking!",
                subtitle: "Follow simple recipes and cook healthy meals at home easily."
            ),
            OnboardingItem(
                lottieName: "onboarding_food",
                title: "Fast Delivery & Follow Up",
                subtitle: "Track your orders in real-time and enjoy your fresh groceries quickly."
            )
        ]

        pages = items.map { OnboardingViewController(item: $0) }
        setViewControllers([pages.first!], direction: .forward, animated: true)
    }

    private func setupNavigationButtons() {
        // Next Button
        var nextConfig = UIButton.Configuration.plain()
        nextConfig.image = UIImage(systemName: "arrow.right.circle.fill")
        nextConfig.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 30, weight: .regular)
        nextConfig.baseForegroundColor = .appPrimary
        nextButton.configuration = nextConfig
        nextButton.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nextButton)

        // Previous Button
        var prevConfig = UIButton.Configuration.plain()
        prevConfig.image = UIImage(systemName: "arrow.left.circle.fill")
        prevConfig.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 30, weight: .regular)
        prevConfig.baseForegroundColor = .systemGray4
        prevButton.configuration = prevConfig
        prevButton.addTarget(self, action: #selector(didTapPrevious), for: .touchUpInside)
        prevButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(prevButton)

        // Constraints
        NSLayoutConstraint.activate([
            nextButton.centerYAnchor.constraint(equalTo: pageControl.centerYAnchor),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            prevButton.centerYAnchor.constraint(equalTo: pageControl.centerYAnchor),
            prevButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }

    func setupPageControl() {
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = .appPrimary
        pageControl.pageIndicatorTintColor = .lightGray

        pageControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pageControl)

        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -150),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

extension OnboardingPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController
    ) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index > 0 else { return nil }
        return pages[index - 1]
    }

    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController
    ) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index < pages.count - 1 else { return nil }
        return pages[index + 1]
    }

    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        if completed, let currentVC = pageViewController.viewControllers?.first,
           let index = pages.firstIndex(of: currentVC) {
            pageControl.currentPage = index
            updateButtonStates(for: currentVC)
        }
    }

    @objc private func didTapNext() {
        guard let currentVC = viewControllers?.first,
              let nextVC = pageViewController(self, viewControllerAfter: currentVC) else { return }
        setViewControllers([nextVC], direction: .forward, animated: true)
        updatePageControl(for: nextVC)
        updateButtonStates(for: nextVC)
    }

    @objc private func didTapPrevious() {
        guard let currentVC = viewControllers?.first,
              let prevVC = pageViewController(self, viewControllerBefore: currentVC) else { return }
        setViewControllers([prevVC], direction: .reverse, animated: true)
        updatePageControl(for: prevVC)
        updateButtonStates(for: prevVC)
    }

    private func updatePageControl(for viewController: UIViewController) {
        if let index = pages.firstIndex(of: viewController) {
            pageControl.currentPage = index
        }
    }

    private func updateButtonStates(for viewController: UIViewController) {
        guard let index = pages.firstIndex(of: viewController) else { return }

        // Previous button
        prevButton.isEnabled = index != 0
        var prevConfig = prevButton.configuration ?? UIButton.Configuration.plain()
        prevConfig.baseForegroundColor = index == 0 ? .systemGray4 : .appPrimary
        prevButton.configuration = prevConfig

        // Next button
        nextButton.isEnabled = index != pages.count - 1
        var nextConfig = nextButton.configuration ?? UIButton.Configuration.plain()
        nextConfig.baseForegroundColor = index == pages.count - 1 ? .systemGray4 : .appPrimary
        nextButton.configuration = nextConfig
    }
}
