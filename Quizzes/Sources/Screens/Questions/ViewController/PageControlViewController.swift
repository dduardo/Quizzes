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
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8.0
        view.backgroundColor = .orange
        
        return view
    }()
    
    private lazy var questionlabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = .zero
        label.font = .appRegularFont(ofSize: .normal)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    private lazy var contentQuestionsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8.0
        view.backgroundColor = .blue
        
        return view
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let vStackView = UIStackView()
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        vStackView.axis = .vertical
        vStackView.alignment = .fill
        vStackView.distribution = .fillEqually
        vStackView.spacing = 20
        
        return vStackView
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let vStackView = UIStackView()
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        vStackView.axis = .horizontal
        vStackView.alignment = .fill
        vStackView.distribution = .fillEqually
        vStackView.spacing = 20
        
        return vStackView
    }()
    
    private lazy var verticalStackView2: UIStackView = {
        let vStackView = UIStackView()
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        vStackView.axis = .horizontal
        vStackView.alignment = .fill
        vStackView.distribution = .fillEqually
        vStackView.spacing = 20
        
        return vStackView
    }()

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
        
        setupView()
    }
}

extension PageControlViewController: ViewCode {
    func setupHierarchy() {
        contentView.addSubview(questionlabel)
        view.addSubview(contentView)
        
        horizontalStackView.addArrangedSubview(verticalStackView)
        horizontalStackView.addArrangedSubview(verticalStackView2)
        contentQuestionsView.addSubview(horizontalStackView)
        view.addSubview(contentQuestionsView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            contentView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            questionlabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            questionlabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 14),
            questionlabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            questionlabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])

        NSLayoutConstraint.activate([
            contentQuestionsView.topAnchor.constraint(equalTo: contentView.bottomAnchor),
            contentQuestionsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            contentQuestionsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            contentQuestionsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            horizontalStackView.topAnchor.constraint(equalTo: contentQuestionsView.topAnchor),
            horizontalStackView.leadingAnchor.constraint(equalTo: contentQuestionsView.leadingAnchor),
            horizontalStackView.trailingAnchor.constraint(equalTo: contentQuestionsView.trailingAnchor),
            horizontalStackView.bottomAnchor.constraint(equalTo: contentQuestionsView.bottomAnchor, constant: -90)
//            horizontalStackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 200)
        ])
        
        verticalStackView.addArrangedSubview(QuestionItemCell(with: questionElement.answers[0]))
        verticalStackView.addArrangedSubview(QuestionItemCell(with: questionElement.answers[1]))
        verticalStackView2.addArrangedSubview(QuestionItemCell(with: questionElement.answers[2]))
        verticalStackView2.addArrangedSubview(QuestionItemCell(with: questionElement.answers[3]))
    }
    
    func setupConfigurations() {
        questionlabel.text = questionElement.question
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
        delegate?.showSuccess()
    }
}
