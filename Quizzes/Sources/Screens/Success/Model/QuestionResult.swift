//
//  QuestionResult.swift
//  Quizzes
//
//  Created by Carlos Eduardo Santiago on 03/05/22.
//

import Foundation

// MARK: - Question
struct QuestionResult: Codable {
    let result: ResultDescription
}

// MARK: - Result
struct ResultDescription: Codable {
    let idQuiz: Int
    let title: String
    let descriptionResult: String
    let result: String
    let image: String

    enum CodingKeys: String, CodingKey {
        case idQuiz = "id_quiz"
        case title
        case descriptionResult = "description_result"
        case result, image
    }
}
