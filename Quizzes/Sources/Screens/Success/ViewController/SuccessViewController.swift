//
//  SuccessViewController.swift
//  Quizzes
//
//  Created by Carlos Eduardo Santiago on 29/04/22.
//

import Foundation
import UIKit

final class SuccessViewController: UIViewController {
    
    var didTapClose: (() -> Void)?
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        var imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        var image = UIImage(named: "close")
        imageView.image = image
        button.setImage(imageView.image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8.0
        view.backgroundColor = .venetianRed
        
        return view
    }()
    
    private lazy var successtitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = .zero
        label.font = .systemFont(ofSize: 42)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    private lazy var contentSuccessView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8.0
        view.backgroundColor = .cultured
        
        return view
    }()
    
    private lazy var successResultLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = .zero
        label.font = .systemFont(ofSize: 16)
        label.textColor = .davyGrey
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping

        return label
    }()
    
    private lazy var successResultDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = .zero
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = .davyGreyLight
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping

        return label
    }()
    
    private lazy var imageResult: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private lazy var shareButtom: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Share", for: .normal)
        button.setTitleColor(.cultured, for: .normal)
        button.backgroundColor = .venetianRed
        button.layer.cornerRadius = 8.0
        
        return button
    }()
    
    private var viewModel: QuestionResultViewModelProtocol

    init(with viewModel: QuestionResultViewModelProtocol = QuestionResultViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .cultured
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cultured
        setupView()
    
        bindViewModel()
    }
    
    // MARK: - Bind View Model

    private func bindViewModel() {
        bindPostResponseCallBack()
    }
    
    private func bindPostResponseCallBack() {
        viewModel.questionResultViewState.bind { [unowned self] value in
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
        successtitleLabel.text = viewModel.model.value?.data?.result.title
        successResultLabel.text = viewModel.model.value?.data?.result.descriptionResult
        successResultDescriptionLabel.text = viewModel.model.value?.data?.result.result
        
        DispatchQueue.main.async {
            self.imageResult.image = self.viewModel.model.value?.data?.result.image.convertBase64StringToImage()
        }
    }
}

extension SuccessViewController: ViewCode{
    func setupHierarchy() {
        view.addSubview(closeButton)
        contentView.addSubview(successtitleLabel)

        contentSuccessView.addSubview(successResultLabel)
        contentSuccessView.addSubview(successResultDescriptionLabel)
        contentSuccessView.addSubview(imageResult)
        contentSuccessView.addSubview(shareButtom)
        contentView.addSubview(contentSuccessView)

        view.addSubview(contentView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            closeButton.widthAnchor.constraint(lessThanOrEqualToConstant: 15),
            closeButton.heightAnchor.constraint(lessThanOrEqualToConstant: 15)
        ])
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            successtitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            successtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            successtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            contentSuccessView.topAnchor.constraint(equalTo: successtitleLabel.bottomAnchor, constant: 16),
            contentSuccessView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            contentSuccessView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            contentSuccessView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            successResultLabel.topAnchor.constraint(equalTo: contentSuccessView.topAnchor, constant: 24),
            successResultLabel.leadingAnchor.constraint(equalTo: contentSuccessView.leadingAnchor, constant: 16),
            successResultLabel.trailingAnchor.constraint(equalTo: contentSuccessView.trailingAnchor, constant: -16)
        ])
        NSLayoutConstraint.activate([
            successResultDescriptionLabel.topAnchor.constraint(equalTo: successResultLabel.bottomAnchor, constant: 8),
            successResultDescriptionLabel.leadingAnchor.constraint(equalTo: contentSuccessView.leadingAnchor, constant: 16),
            successResultDescriptionLabel.trailingAnchor.constraint(equalTo: contentSuccessView.trailingAnchor, constant: -16)
        ])

        NSLayoutConstraint.activate([
            imageResult.topAnchor.constraint(equalTo: successResultDescriptionLabel.bottomAnchor, constant: 20),
            imageResult.leadingAnchor.constraint(equalTo: contentSuccessView.leadingAnchor, constant: 16),
            imageResult.trailingAnchor.constraint(equalTo: contentSuccessView.trailingAnchor, constant: -16),
            imageResult.widthAnchor.constraint(lessThanOrEqualToConstant: 300),
            imageResult.heightAnchor.constraint(lessThanOrEqualToConstant: 300)
        ])
        
        NSLayoutConstraint.activate([
            shareButtom.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            shareButtom.leadingAnchor.constraint(equalTo: contentSuccessView.leadingAnchor, constant: 30),
            shareButtom.trailingAnchor.constraint(equalTo: contentSuccessView.trailingAnchor, constant: -30),
            shareButtom.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setupConfigurations() {
        viewModel.fetchSuccess()
        closeButton.addTarget(self, action: #selector(didTapCloseButton(_:)), for: .touchUpInside)
        shareButtom.addTarget(self, action: #selector(didTapShareButton(_:)), for: .touchUpInside)
    }

    @objc
    private func didTapCloseButton(_ sender: Any) {
        didTapClose?()
    }
    
    @objc
    private func didTapShareButton(_ sender: Any) {
        didTapClose?()
    }
}
