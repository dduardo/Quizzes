//
//  AboutViewController.swift
//  Quizzes
//
//  Created by Carlos Eduardo Santiago on 29/04/22.
//

import Foundation
import UIKit

final class AboutViewController: UIViewController {

    var didSendEventClosure: ((AboutViewController.Event) -> Void)?

    private let readyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Ready", for: .normal)
        button.backgroundColor = .systemRed
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8.0

        return button
    }()

    private lazy var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "ABOUT"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "About"
        // Do any additional setup after loading the view.
        view.backgroundColor = .white

        view.addSubview(label)

        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.widthAnchor.constraint(equalToConstant: 200),
            label.heightAnchor.constraint(equalToConstant: 50)
        ])

//        label.addTarget(self, action: #selector(didTapReadyButton(_:)), for: .touchUpInside)
    }

    deinit {
        print("AboutViewController deinit")
    }

    @objc private func didTapReadyButton(_ sender: Any) {
        didSendEventClosure?(.ready)
    }
}

extension AboutViewController {
    enum Event {
        case ready
    }
}
