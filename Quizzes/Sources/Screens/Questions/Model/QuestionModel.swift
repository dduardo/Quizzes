//
//  QuestionModel.swift
//  Quizzes
//
//  Created by Carlos Eduardo Santiago on 02/05/22.
//

import Foundation

// MARK: - QuestionModel

struct QuestionModel: Codable {
    let errors: [String]?
    let data: Quiz?
}

struct Quiz: Codable {
    let idQuiz: String
    let idQuizHome: String
    let questionDescription: Description
    let questions: [QuestionElement]

    enum CodingKeys: String, CodingKey {
        case idQuiz = "id_quiz"
        case idQuizHome = "id_quiz_home"
        case questionDescription = "description"
        case questions
    }
}

// MARK: - Description
struct Description: Codable {
    let group: String
    let image: String
    let headline: String
    let descriptionDescription: String

    enum CodingKeys: String, CodingKey {
        case group
        case image
        case headline
        case descriptionDescription = "description"
    }
}

// MARK: - QuestionElement
struct QuestionElement: Codable {
    let question: String
    let idQuestion: String
    let answers: [Answer]
    var check: Bool?
    
    enum CodingKeys: String, CodingKey {
        case question
        case idQuestion = "id_question"
        case answers
    }
}

// MARK: - Answer
struct Answer: Codable {
    let image: String
    let option: String
    let value: Int
}

