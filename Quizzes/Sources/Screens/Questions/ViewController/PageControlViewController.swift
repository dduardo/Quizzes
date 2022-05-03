//
//  PageControlViewController.swift
//  Quizzes
//
//  Created by Carlos Eduardo Santiago on 29/04/22.
//

import UIKit

enum Pages: CaseIterable {
    case pageZero
    case pageOne
    case pageTwo
    case pageThree
    
    var name: String {
        switch self {
        case .pageZero:
            return "This is page zero"
        case .pageOne:
            return "This is page one"
        case .pageTwo:
            return "This is page two"
        case .pageThree:
            return "This is page three"
        }
    }
    
    var index: Int {
        switch self {
        case .pageZero:
            return 0
        case .pageOne:
            return 1
        case .pageTwo:
            return 2
        case .pageThree:
            return 3
        }
    }
}

protocol PageVCDelegate: class {
    func showSuccess()
}

final class PageControlViewController: UIViewController {

    var page: Pages
    private var questionElement: QuestionElement
    private var isLast: Bool
    weak var delegate: PageVCDelegate?
    
    private let steadyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Validar", for: .normal)
        button.backgroundColor = .systemYellow
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8.0
        button.isHidden = true
        
        return button
    }()
    
    init(with questionElement: QuestionElement, page: Pages, isLast: Bool = false) {
        self.questionElement = questionElement
        self.page = page
        self.isLast = isLast
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        // callback para limpar a pilha de controller n coordinator
        print("PageControlViewController deinit")
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label = UILabel()
        label.text = questionElement.question
        label.numberOfLines = 0
        
        view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        
        
        setupView()
    }
}

extension PageControlViewController: ViewCode {
    func setupHierarchy() {
    
    }
    
    func setupConstraints() {
    
    }
    
    func setupConfigurations() {
        showButtonSuccess()
    }
}

extension PageControlViewController {
    
    private func showButtonSuccess() {
        if isLast {
            DispatchQueue.main.async {
                self.setupButtom()
            }
        }
    }
    
    private func setupButtom() {
        view.addSubview(steadyButton)

        steadyButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            steadyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            steadyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            steadyButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            steadyButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        steadyButton.addTarget(self, action: #selector(didTapSteadyButton(_:)), for: .touchUpInside)
        
        steadyButton.isHidden = false
    }

    @objc
    private func didTapSteadyButton(_ sender: Any) {
        print("delegate button")
        delegate?.showSuccess()
    }
}
