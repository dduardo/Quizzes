//
//  UIBanner.swift
//  Quizzes
//
//  Created by Carlos Eduardo Santiago on 05/05/22.
//

import Foundation
import UIKit

protocol UIBannerViewDelegate {
    
}

class UIBannerView: UIView, Identifiable {
    
    private var message: String
    private var delegate: UIBannerViewDelegate
    
    private lazy var containerView: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = .purple
        return container
    }()

    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    init(with message: String, delegate: UIBannerViewDelegate) {
        self.message = message
        self.delegate = delegate
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showBanner() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveLinear, animations: {
                self.containerView.frame.origin.y = 0
            }) { (finished) in
                UIView.animate(withDuration: 0.4,delay: 2.0, options: .curveLinear, animations: { [self] in
                    self.containerView.frame.origin.y = -self.containerView.frame.size.height
                })
            }
        }
    }
}

extension UIBannerView: ViewCode {
    func setupHierarchy() {
        containerView.addSubview(label)
        addSubview(containerView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,constant: -20),
            label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            label.bottomAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.bottomAnchor, constant: -20),
        ])
    }
    
    func setupConfigurations() {
        label.text = message
    }
}
