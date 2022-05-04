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

    var didShowSuccess: (() -> Void)?
    
    // MARK: - ViewCode
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = .zero
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping

        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = .zero
        label.font = UIFont.systemFont(ofSize: 14)
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
    
    private func handleSuccess() {
        guard let questionDescription = viewModel.model.value?.questionDescription, let questions = viewModel.model.value?.questions[0] else { return }
        titleLabel.text = questionDescription.headline
        descriptionLabel.text = questionDescription.descriptionDescription
 
        let initialVC = PageControlViewController(with: questions, page: pages[0])
        self.pageController.setViewControllers([initialVC], direction: .forward, animated: true, completion: nil)
    }

    private func setupPageController() {
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
        view.backgroundColor = .white
        setupPageController()
        viewModel.fetchQuestions()
    }
}

extension QuestionsViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        //Contar index no viewModel
        
        guard let currentVC = viewController as? PageControlViewController, let model = viewModel.model.value?.questions else {
            return nil
        }

        var index = currentVC.page.index
        if index == 0 {
            return nil
        }
        
        index -= 1

        
        let vc: PageControlViewController = PageControlViewController(with: model[index - 1], page: pages[index], isLast: index == self.pages.count - 1)
        vc.delegate = self
        return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        //Contar index no viewModel
        
        guard let currentVC = viewController as? PageControlViewController, let model = viewModel.model.value?.questions else {
            return nil
        }
        
        var index = currentVC.page.index
        if index >= self.pages.count - 1 {
            return nil
        }
        
        index += 1

        let vc: PageControlViewController = PageControlViewController(with: model[index - 1], page: pages[index], isLast: index == self.pages.count - 1)
        vc.delegate = self
        return vc
    }
}

extension QuestionsViewController: UIPageViewControllerDataSource{
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return viewModel.model.value?.questions.count ?? 0
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return self.currentIndex
    }
}

extension QuestionsViewController: PageVCDelegate {
    func showSuccess() {
        didShowSuccess?()
    }
}
