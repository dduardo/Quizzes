//
//  QuestionItemCell.swift
//  Quizzes
//
//  Created by Carlos Eduardo Santiago on 03/05/22.
//

import Foundation
import UIKit


protocol QuestionItemCellDelegate: AnyObject {
    func choose(value: Int)
}

final class QuestionItemCell: UIView, Identifiable {
    
    private var delegate: QuestionItemCellDelegate
    
    private var answer: Answer
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8.0
        view.backgroundColor = .lightGray
        view.layer.borderWidth = 1.0
        view.layer.masksToBounds = false
        view.layer.borderColor = UIColor.darkGray.cgColor.copy(alpha: 1)

        return view
    }()

    private lazy var answerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()
    
    private lazy var answerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .cultured
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = .zero

        return label
    }()
    
    init(with answer: Answer, delegate: QuestionItemCellDelegate) {
        self.answer = answer
        self.delegate = delegate
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        answerImageView.image = answer.image.convertBase64StringToImage()
    }
}

extension QuestionItemCell: ViewCode {
    func setupHierarchy() {
        contentView.addSubview(answerImageView)
        contentView.addSubview(answerLabel)
        
        addSubview(contentView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: self.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 132)
        ])
        
        NSLayoutConstraint.activate([
            answerImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 8),

            answerImageView.heightAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.heightAnchor, multiplier: 1.0 / 1.5),

            answerImageView.widthAnchor.constraint(equalTo: answerImageView.heightAnchor),

            answerImageView.centerXAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            answerLabel.topAnchor.constraint(equalTo: answerImageView.bottomAnchor),
            answerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            answerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            answerLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func setupConfigurations() {
        answerLabel.text = answer.option
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        contentView.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        checkIsSelected()
        delegate.choose(value: answer.value)
    }
}

extension QuestionItemCell {
    
    private func checkIsSelected() {
        if !(answer.isSelected ?? false) {
            contentView.backgroundColor = .darkGray
        } else {
            contentView.backgroundColor = .lightGray
        }
    }
}
