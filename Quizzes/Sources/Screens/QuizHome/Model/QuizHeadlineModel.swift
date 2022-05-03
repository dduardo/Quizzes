//
//  QuizHeadlineModel.swift
//  Quizzes
//
//  Created by Carlos Eduardo Santiago on 02/05/22.
//

import Foundation

// MARK: - Welcome
struct QuizHeadlineModel: Codable {
    let quizList: [QuizItem]

    enum CodingKeys: String, CodingKey {
        case quizList = "quiz_list"
    }
}

// MARK: - QuizList
struct QuizItem: Codable {
    let idQuiz: Int
    let group: String
    let image: String
    let headline: String
    let quizListDescription: String

    enum CodingKeys: String, CodingKey {
        case idQuiz = "id_quiz"
        case group
        case image
        case headline
        case quizListDescription = "description"
    }
}
