//
//  SuccessCoordinator.swift
//  Quizzes
//
//  Created by Carlos Eduardo Santiago on 29/04/22.
//

import Foundation
import UIKit

protocol SuccessCoordinatorProtocol: Coordinator {
    func showSuccessViewController()
}

final class SuccessCoordinator: SuccessCoordinatorProtocol {
    weak var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType { .login }
    
    var resultQuiz: ResultQuiz?
        
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
       
    convenience init(_ navigationController: UINavigationController, and resultQuiz: ResultQuiz) {
        self.init(navigationController)
        
        self.navigationController = navigationController
        self.resultQuiz = resultQuiz
    }
    
    func start() {
        showSuccessViewController()
    }
    
    deinit {
        print("LoginCoordinator deinit")
    }
    
    func showSuccessViewController() {
        guard let resultQuiz = resultQuiz else { return }
        let viewModel = QuestionResultViewModel(with: resultQuiz)
        let successViewController: SuccessViewController = .init(with: viewModel)
        successViewController.didTapClose = poptoRootViewController
        successViewController.modalPresentationStyle = .fullScreen
        
        navigationController.present(successViewController, animated: true, completion: nil)
        navigationController.setNavigationBarHidden(false, animated: false)
        navigationController.tabBarController?.hidesBottomBarWhenPushed = false
    }
}

extension SuccessCoordinator {
    
    private func popViewController() {
        finish()
    }
    
    private func poptoRootViewController() {
        navigationController.dismiss(animated: true, completion: {
            self.navigationController.popToRootViewController(animated: true)
            self.finish()
        })
    }
}
