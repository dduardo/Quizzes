//
//  QuizHeadlineModel.swift
//  Quizzes
//
//  Created by Carlos Eduardo Santiago on 02/05/22.
//

import Foundation

// MARK: - QuizList
struct QuizItem: Codable {
    let idQuizHome: String
    let group: String
    let image: String
    let headline: String
    let quizListDescription: String

    enum CodingKeys: String, CodingKey {
        case idQuizHome
        case group
        case image
        case headline
        case quizListDescription = "description"
    }
}

// MARK: - QuizHome
struct QuizHome: Codable {
    let errors: [String]?
    let data: QuizHeadlineModel?
}

// MARK: - DataClass
struct QuizHeadlineModel: Codable {
    let content: [QuizItem]
    let pageable: Pageable
    let last: Bool
    let totalPages, totalElements, size, number: Int
    let sort: Sort
    let numberOfElements: Int
    let first, empty: Bool
}


// MARK: - Pageable
struct Pageable: Codable {
    let sort: Sort
    let offset, pageNumber, pageSize: Int
    let paged, unpaged: Bool
}

// MARK: - Sort
struct Sort: Codable {
    let empty, sorted, unsorted: Bool
}
