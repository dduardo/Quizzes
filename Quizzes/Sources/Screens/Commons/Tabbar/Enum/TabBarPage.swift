//
//  TabBarPage.swift
//  Quizzes
//
//  Created by Carlos Eduardo Santiago on 29/04/22.
//

import Foundation

enum TabBarPage {
    case home
    case about
//    case go

    init?(index: Int) {
        switch index {
        case 0:
            self = .home
        case 1:
            self = .about
//        case 2:
//            self = .go
        default:
            return nil
        }
    }
    
    func pageTitleValue() -> String {
        switch self {
        case .home:
            return "Home"
        case .about:
            return "About"
//        case .go:
//            return "Go"
        }
    }

    func pageOrderNumber() -> Int {
        switch self {
        case .home:
            return 0
        case .about:
            return 1
//        case .go:
//            return 2
        }
    }

    // Add tab icon value
    
    // Add tab icon selected / deselected color
    
    // etc
}
