//
//  QuestionsViewController.swift
//  Quizzes
//
//  Created by Carlos Eduardo Santiago on 29/04/22.
//

import Foundation
import UIKit

final class QuestionsViewController: UIViewController {
    
    // MARK: - Callbacks

    var didShowSuccess: ((ResultQuiz) -> Void)?
    
    // MARK: - ViewCode
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = .zero
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.textColor = .davyGrey
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping

        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = .zero
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .davyGreyLight
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping

        return label
    }()
    
    private var pageController: UIPageViewController = {
        let pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageController.view.translatesAutoresizingMaskIntoConstraints = false
        pageController.view.backgroundColor = .clear
        
        return pageController
    }()
    
    private var pages: [Pages] = Pages.allCases
    private var currentIndex: Int = 0
    private var viewModel: QuestionsViewModelProtocol
    private var pageControlViewControllers: [UIViewController] = []

    // MARK - Override and Initializers
    
    public init(with viewModel: QuestionsViewModelProtocol = QuestionsViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Questions"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

        bindViewModel()
    }
    
    // MARK: - Bind View Model

    private func bindViewModel() {
        bindPostResponseCallBack()
        bindCompletionQuiz()
    }
    
    private func bindPostResponseCallBack() {
        viewModel.questionsViewState.bind(skip: true) { [unowned self] value in
            switch value {
            case .loading:
                break
            case .loaded:
                self.handleSuccess()                
            case .error:
                break
            default:
                break
            }
        }
    }
    
    private func bindCompletionQuiz() {
        viewModel.completionQuiz.bind(skip: true) { [unowned self] value in
            switch value {
            case .succeed(let result):
                didShowSuccess?(result)
            case .didNotAnswerAll:
                DispatchQueue.main.async {
                    UIBannerView(with: "PAty", delegate: self).showBanner()
                }
                break
            case .none:
                break
            }
        }
    }
    
    private func handleSuccess() {
        guard let questionDescription = viewModel.model.value?.data?.questionDescription else { return }
        DispatchQueue.main.async {
            self.titleLabel.text = questionDescription.headline
            self.descriptionLabel.text = questionDescription.descriptionDescription
            self.setupPageController()
        }
    }
    
    private func setupPageController() {
        guard let questions = viewModel.model.value?.data?.questions else { return }
        
        for (index, question) in questions.enumerated() {
            let pageControl = PageControlViewController(with: pages[index], isLast: index >= questions.count - 1, questionElement: question)
            pageControl.delegate = self
            pageControlViewControllers.append(pageControl)
        }
        
        self.pageController.setViewControllers([pageControlViewControllers[0]], direction: .forward, animated: true, completion: nil)
        
        pageController.dataSource = self
        pageController.delegate = self
    }
}

// MARK: - Extension ViewCode

extension QuestionsViewController: ViewCode {
    func setupHierarchy() {
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(pageController.view)

        pageController.didMove(toParent: self)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
        
        let titleHeightConstraint = titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 24)
        titleHeightConstraint.priority = UILayoutPriority(rawValue: 500)
        titleHeightConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 14),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
        
        let descriptionHeightConstraint = descriptionLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 16)
        descriptionHeightConstraint.priority = UILayoutPriority(rawValue: 500)
        descriptionHeightConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            pageController.view.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 14),
            pageController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setupConfigurations() {
        view.backgroundColor = .cultured
        viewModel.fetchQuestions()
    }
}

extension QuestionsViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pageControlViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard pageControlViewControllers.count > previousIndex else {
            return nil
        }
        
        return pageControlViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pageControlViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let pageControlViewControllersCount = pageControlViewControllers.count

        guard pageControlViewControllersCount != nextIndex else {
            return nil
        }
        
        guard pageControlViewControllersCount > nextIndex else {
            return nil
        }
        
        return pageControlViewControllers[nextIndex]
    }
}

extension QuestionsViewController: UIPageViewControllerDataSource {

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pageControlViewControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return self.currentIndex
    }
}

extension QuestionsViewController: PageVCDelegate {

    func chosenItem(id: String, answerValue: Int) {
        viewModel.addChosenItem(with: id, answerValue: answerValue)
    }
    
    func showSuccess() {
        viewModel.checkQuiz()
    }
}

extension QuestionsViewController: UIBannerViewDelegate {
    
}
