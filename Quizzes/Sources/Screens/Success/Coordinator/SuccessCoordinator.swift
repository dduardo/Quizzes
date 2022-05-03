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
        
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
        
    func start() {
        showSuccessViewController()
    }
    
    deinit {
        print("LoginCoordinator deinit")
    }
    
    func showSuccessViewController() {
        let successViewController: SuccessViewController = .init()
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
//        navigationController.popViewController(animated: false)
//        poptoRootViewController()
    }
    
    private func poptoRootViewController() {
        navigationController.dismiss(animated: true, completion: {
            self.navigationController.popToRootViewController(animated: true)
            self.finish()
        })
    }
}
