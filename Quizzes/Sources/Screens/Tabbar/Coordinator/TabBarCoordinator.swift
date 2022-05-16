//
//  TabBarCoordinator.swift
//  Quizzes
//
//  Created by Carlos Eduardo Santiago on 29/04/22.
//

import Foundation
import UIKit

protocol TabBarCoordinatorProtocol: Coordinator {
    var tabBarController: UITabBarController { get set }
    
    func selectPage(_ page: TabBarPage)
    
    func setSelectedIndex(_ index: Int)
    
    func currentPage() -> TabBarPage?
}

class TabBarCoordinator: NSObject, Coordinator {
    weak var finishDelegate: CoordinatorFinishDelegate?
        
    var childCoordinators: [Coordinator] = []

    var navigationController: UINavigationController
    
    var tabBarController: UITabBarController

    var type: CoordinatorType { .tab }
    
    var quizHomeCoordinator: QuizHomeCoordinator?
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarController = .init()
        tabBarController.navigationItem.title = "Fuzz beed"
        tabBarController.tabBar.backgroundColor = .cultured
    }

    func start() {
        // Let's define which pages do we want to add into tab bar
        let pages: [TabBarPage] = [.home, .about]
            .sorted(by: { $0.pageOrderNumber() < $1.pageOrderNumber() })
        
        // Initialization of ViewControllers or these pages
        let controllers: [UINavigationController] = pages.map({ getTabController($0) })
        
        prepareTabBarController(withTabControllers: controllers)
    }
    
    deinit {
        print("TabCoordinator deinit")
    }
    
    private func prepareTabBarController(withTabControllers tabControllers: [UIViewController]) {
        tabBarController.delegate = self
        tabBarController.setViewControllers(tabControllers, animated: true)
        tabBarController.selectedIndex = TabBarPage.home.pageOrderNumber()
        tabBarController.tabBar.isTranslucent = true

        navigationController.viewControllers = [tabBarController]
    }
      
    private func getTabController(_ page: TabBarPage) -> UINavigationController {
        let navController = UINavigationController()
        navController.setNavigationBarHidden(true, animated: false)

        navController.tabBarItem = UITabBarItem.init(title: page.pageTitleValue(),
                                                     image: nil,
                                                     tag: page.pageOrderNumber())

        switch page {
        case .home:
            // If needed: Each tab bar flow can have it's own Coordinator.
            let quizHomeViewController = QuizHomeViewController()
            quizHomeViewController.cellDidTapeped = showQuestions
            
            navController.pushViewController(quizHomeViewController, animated: true)
        case .about:
            let aboutViewController = AboutViewController()
            aboutViewController.didSendEventClosure = { [weak self] event in
                switch event {
                case .ready:
                    self?.selectPage(.home)
                }
            }
            
            navController.pushViewController(aboutViewController, animated: true)
        }
        
        return navController
    }
    
    func currentPage() -> TabBarPage? { TabBarPage.init(index: tabBarController.selectedIndex) }

    func selectPage(_ page: TabBarPage) {
        tabBarController.selectedIndex = page.pageOrderNumber()
    }
    
    func setSelectedIndex(_ index: Int) {
        guard let page = TabBarPage.init(index: index) else { return }
        
        tabBarController.selectedIndex = page.pageOrderNumber()
    }
}

// MARK: - UITabBarControllerDelegate
extension TabBarCoordinator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController,
                          didSelect viewController: UIViewController) {
        // Some implementation
    }
}

extension TabBarCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        finish()
        
        start()
    }
}

extension TabBarCoordinator {
    
    func showQuestions(value: String) {
        let coordiantor = QuestionsCoordinator.init(navigationController, idQuizHome: value)
        coordiantor.finishDelegate = self
        coordiantor.start()
        childCoordinators.append(coordiantor)        
    }
}
