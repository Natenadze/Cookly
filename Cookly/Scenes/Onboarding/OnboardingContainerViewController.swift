//
//  OnboardingContainerViewController.swift
//  Cookly
//
//  Created by Davit Natenadze on 21.03.24.
//

import UIKit

protocol OnboardingContainerVCDelegate: AnyObject {
    func didFinishOnboarding()
}

class OnboardingContainerVC: UIViewController {
    
    let onboardingPagesContainer: UIPageViewController
    
    var pages = [UIViewController]()
    var currentOnboardingVC: UIViewController
    let closeButton = UIButton(type: .system)
    
    weak var delegate: OnboardingContainerVCDelegate?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        style()
        layout()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        onboardingPagesContainer = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal,
            options: nil
        )
        
        let page1 = OnboardingVC(
            imageName: "logo",
            titleText: "Cookly is asiasjdioas asok ansdok sajdaskn dasd aslkdasljd as;lkdma."
        )
        let page2 = OnboardingVC(
            imageName: "pizza",
            titleText: "Find your recipes daklsdna ldas lkndaslknd as."
        )
        let page3 = OnboardingVC(
            imageName: "chicken",
            titleText: "Learn more at www.cookly.com."
        )
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        
        currentOnboardingVC = pages[0]
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setup() {
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .systemOrange
        addChild(onboardingPagesContainer)
        view.addSubview(onboardingPagesContainer.view)
        onboardingPagesContainer.didMove(toParent: self)
        onboardingPagesContainer.dataSource = self
        onboardingPagesContainer.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: onboardingPagesContainer.view.topAnchor),
            view.leadingAnchor.constraint(equalTo: onboardingPagesContainer.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: onboardingPagesContainer.view.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: onboardingPagesContainer.view.bottomAnchor),
        ])
        
        onboardingPagesContainer.setViewControllers([pages.first!], direction: .forward, animated: false, completion: nil)
    }
    
    private func style() {
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.setTitle("Close", for: [])
        closeButton.addAction(UIAction(handler: { _ in
            self.closeTapped()
        }), for: .touchUpInside)
    }
    
    private func layout() {
        view.addSubview(closeButton)
        NSLayoutConstraint.activate([
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: closeButton.trailingAnchor, multiplier: 2),
            closeButton.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2)
        ])
    }
    
}

// MARK: - UIPageViewControllerDataSource
extension OnboardingContainerVC: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index - 1 >= 0 else { return nil }
        currentOnboardingVC = pages[index - 1]
        return currentOnboardingVC
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index + 1 < pages.count else { return nil }
        currentOnboardingVC = pages[index + 1]
        return currentOnboardingVC
    }
    
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        pages.firstIndex(of: self.currentOnboardingVC) ?? 0
    }
}

// MARK: - Actions

extension OnboardingContainerVC {
    func closeTapped() {
        delegate?.didFinishOnboarding()
    }
}
