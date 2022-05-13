//
//  QuestionsCoordinator.swift
//  Quizzes
//
//  Created by Carlos Eduardo Santiago on 29/04/22.
//

import Foundation
import UIKit

class QuestionsCoordinator: Coordinator {

    weak var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType { .login }
    
    private var idQuizHome: String = String()
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    convenience init(_ navigationController: UINavigationController, idQuizHome: String) {
        self.init(navigationController)
        self.idQuizHome = idQuizHome
    }
        
    func start() {
        let viewModel = QuestionsViewModel(with: idQuizHome)
        let questionsViewController: QuestionsViewController = .init(with: viewModel)
        questionsViewController.didShowSuccess = showSuccess
        questionsViewController.tabBarController?.tabBar.isHidden = false
        navigationController.pushViewController(questionsViewController, animated: true)
        navigationController.setNavigationBarHidden(false, animated: false) 
    }
    
    deinit {
        print("LoginCoordinator deinit")
    }
}

extension QuestionsCoordinator {
    
    private func showSuccess(with resultQuiz: ResultQuiz) {
        let successCoordinator = SuccessCoordinator.init(navigationController, and: resultQuiz)
        successCoordinator.finishDelegate = self
        successCoordinator.start()
        childCoordinators.append(successCoordinator)
    }
}

extension QuestionsCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        
    }
}
