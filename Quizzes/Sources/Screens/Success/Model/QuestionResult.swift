//
//  QuestionResult.swift
//  Quizzes
//
//  Created by Carlos Eduardo Santiago on 03/05/22.
//

import Foundation

// MARK: - QuestionResult
struct QuestionResult: Codable {
    let errors: [String]?
    let data: QuestionResultModel?
}

// MARK: - QuestionResultModel
struct QuestionResultModel: Codable {
    let idQuizResult: String
    let idQuiz: String
    let result: ResultDescription
}

// MARK: - Result
struct ResultDescription: Codable {
    let title: String
    let descriptionResult: String
    let result: String
    let image: String
}
