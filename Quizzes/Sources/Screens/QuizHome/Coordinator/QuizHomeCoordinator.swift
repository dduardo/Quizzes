//
//  QuizHomeCoordinator.swift
//  Quizzes
//
//  Created by Carlos Eduardo Santiago on 29/04/22.
//

import Foundation
import UIKit

protocol QuizHomeCoordinatorProtocol: Coordinator {
    func showQuizHomeViewController()
}

class QuizHomeCoordinator: QuizHomeCoordinatorProtocol {
    weak var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType { .login }
        
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
        
    func start() {
        showQuizHomeViewController()
    }
    
    deinit {
        print("LoginCoordinator deinit")
    }
    
    func showQuizHomeViewController() {
        let quizHomeViewController: QuizHomeViewController = .init()
        navigationController.pushViewController(quizHomeViewController, animated: true)
    }
}
