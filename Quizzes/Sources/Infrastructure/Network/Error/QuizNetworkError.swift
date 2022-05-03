//
//  QuizNetworkError.swift
//  Quizzes
//
//  Created by Carlos Eduardo Santiago on 02/05/22.
//

import Foundation

public enum QuizNetworkError: Error {
    case emptyData
    case defaultError(Error)
    case responseEmpty
    case defaultError(Error, Int, Data?)
    case linkNotFound
}
