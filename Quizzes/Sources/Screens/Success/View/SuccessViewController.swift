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
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        var imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        var image = UIImage(named: "close")
        imageView.image = image

        button.setImage(imageView.image, for: .normal)
//        button.setTitle("X", for: .normal)
//        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
//        label.center = CGPoint(x: 160, y: 250)
        label.textAlignment = NSTextAlignment.center
        
        return label
    }()
    
    deinit {
        print("Success deinit")
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow

        setupUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("viewDidDisappear")
    }
}

extension SuccessViewController {
    
    private func setupUI() {
        titleLabel.text = "Success"
        
        self.view.addSubview(closeButton)
        self.view.addSubview(titleLabel)

        closeButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            closeButton.widthAnchor.constraint(equalToConstant: 30),
            closeButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 180),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
//            titleLabel.widthAnchor.constraint(equalToConstant: 50),
//            titleLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        closeButton.addTarget(self, action: #selector(didTapCloseButton(_:)), for: .touchUpInside)
    }
    
    
    @objc
    private func didTapCloseButton(_ sender: Any) {
        didTapClose?()
//        dismiss(animated: true, completion: didTapClose)
    }
}
