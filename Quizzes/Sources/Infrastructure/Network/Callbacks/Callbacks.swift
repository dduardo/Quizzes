//
//  Callbacks.swift
//  Quizzes
//
//  Created by Carlos Eduardo Santiago on 02/05/22.
//

import Foundation

public typealias CompletionDataCallback<T: Decodable> = ((Result<T, QuizNetworkError>) -> Void)

enum GetHomeQuizzesCallBack {
    case succeed(QuizHeadlineModel)
    case error(QuizNetworkError)
}
