//
//  QuizCell.swift
//  Quizzes
//
//  Created by Carlos Eduardo Santiago on 02/05/22.
//

import Foundation
import UIKit

final class QuizCell: UITableViewCell, Identifiable {
    
    // MARK: - Private Vars

    private var model: QuizItem?

    // MARK: - ViewCode

    private lazy var roundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
//        NSLayoutConstraint.activate([
//            imageView.widthAnchor.constraint(equalToConstant: 80),
//            imageView.heightAnchor.constraint(equalToConstant: 80)
//        ])

        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = .zero
        label.font = .appBoldFont(ofSize: .subTitle)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping

        return label
    }()

    lazy var imageViewRightArrow: UIImageView = {
        let imageView = UIImageView(image: UIImage.init(named: "Arrow"))
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 20),
            imageView.heightAnchor.constraint(equalToConstant: 20)
        ])

        return imageView
    }()

    private lazy var labelDescription: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        label.textAlignment = .left
        label.font = .appRegularFont(ofSize: .normal)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping

        return label
    }()

    let separator: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        return view
    }()

    // MARK: - Life Cycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    override func awakeFromNib() {
       super.awakeFromNib()
    }
    
    // MARK: - Public Methods

    func setup(with model: QuizItem) {
        self.model = model
        
        setupView()
        setupValues()
    }
    
    override func draw(_ rect: CGRect) {
        roundImageView.image = UIImage.init(named: "panela")
        roundImageView.circularImage()
    }
}

extension QuizCell: ViewCode {

    func setupHierarchy() {
        contentView.addSubview(roundImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(labelDescription)
//        contentView.addSubview(imageViewRightArrow)
    }
    
    func setupConstraints() {
        setupContentViewConstraints()
        setupRoundImageViewConstraints()
        setupLabelTitleConstraints()
        setupLabelDescriptionConstraints()
//        setupImageViewRightArrowConstraints()
    }
    
    func setupConfigurations() {
        selectionStyle = .none
    }
    
    private func setupContentViewConstraints() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: self.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 90)
        ])
    }
    
    private func setupValues() {
        titleLabel.text = model?.headline
        labelDescription.text = model?.quizListDescription
    }

    private func setupRoundImageViewConstraints() {
        NSLayoutConstraint.activate([
            roundImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 8),

            roundImageView.heightAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.heightAnchor, multiplier: 1.0 / 1.5),

            roundImageView.widthAnchor.constraint(equalTo: roundImageView.heightAnchor),

            roundImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        ])
    }

    private func setupLabelTitleConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: roundImageView.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30)
        ])
    }

    private func setupImageViewRightArrowConstraints() {
        NSLayoutConstraint.activate([
            imageViewRightArrow.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            imageViewRightArrow.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30)
        ])
    }

    private func setupLabelDescriptionConstraints() {
        NSLayoutConstraint.activate([
            labelDescription.topAnchor.constraint(greaterThanOrEqualTo: titleLabel.bottomAnchor, constant: 8),
            labelDescription.leadingAnchor.constraint(equalTo: roundImageView.trailingAnchor, constant: 16),
            labelDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30)
        ])
    }
}
