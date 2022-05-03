//
//  QuestionsCoordinator.swift
//  Quizzes
//
//  Created by Carlos Eduardo Santiago on 29/04/22.
//

import Foundation
import UIKit

protocol QuestionsCoordinatorProtocol: Coordinator {
    func showQuestionsViewController()
}

class QuestionsCoordinator: QuestionsCoordinatorProtocol {
    weak var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType { .login }
        
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
        
    func start() {
        showQuestionsViewController()
    }
    
    deinit {
        print("LoginCoordinator deinit")
    }
    
    func showQuestionsViewController() {
        let questionsViewController: QuestionsViewController = .init()
        questionsViewController.didShowSuccess = showSuccess        
        questionsViewController.tabBarController?.tabBar.isHidden = false
        navigationController.pushViewController(questionsViewController, animated: true)
        navigationController.setNavigationBarHidden(false, animated: false)        
    }
}

extension QuestionsCoordinator {
    
    private func showSuccess() {
        let successCoordinator = SuccessCoordinator.init(navigationController)
        successCoordinator.finishDelegate = self
        successCoordinator.start()
        childCoordinators.append(successCoordinator)
    }
}

extension QuestionsCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        
    }
}
