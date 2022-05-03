//
//  QuizzesNetwork.swift
//  Quizzes
//
//  Created by Carlos Eduardo Santiago on 02/05/22.
//

import Foundation

public typealias NetworkResult<T: Decodable> = Result<T, QuizNetworkError>

// MARK: Protocol

protocol QuizzesNetworkProtocol: AnyObject {
    func request<T: Decodable>(endPoint: Links, completion: @escaping CompletionDataCallback<T>)
}

// MARK: QuizzesNetwork Implementation

class QuizzesNetwork: QuizzesNetworkProtocol {
    func request<T: Decodable>(endPoint: Links, completion: @escaping CompletionDataCallback<T>) {
        
    }
}
