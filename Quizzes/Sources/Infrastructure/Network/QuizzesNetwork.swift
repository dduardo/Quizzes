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
    func request<T: Decodable>(endPoint: Links, params: Dictionary<String, Any>?, completion: @escaping CompletionDataCallback<T>)
}

// MARK: QuizzesNetwork Implementation

class QuizzesNetwork: QuizzesNetworkProtocol {
    func request<T: Decodable>(endPoint: Links, params: Dictionary<String, Any>? = nil, completion: @escaping CompletionDataCallback<T>) {
        guard let url = URL(string: "http://localhost:8080/api/\(endPoint.rawValue)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        if let params = params {
             let  jsonData = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
             request.httpBody = jsonData
         }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(.linkNotFound))
                return
            }
        
            do {
                let entities = try JSONDecoder().decode(T.self, from: data)
                completion(.success(entities))
            } catch {
                completion(.failure(.defaultError(error)))
            }
        }
        
        task.resume()
    }
}
