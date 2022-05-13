//
//  ViewCode.swift
//  Quizzes
//
//  Created by Carlos Eduardo Santiago on 02/05/22.
//

import UIKit

public protocol ViewCode {
    func setupHierarchy()
    func setupConstraints()
    func setupConfigurations()
}

public extension ViewCode {
    func setupView() {
        setupHierarchy()
        setupConstraints()
        setupConfigurations()
    }
    
    func setupConfigurations() {
//        Intentionally not implemented
    }
    
}
