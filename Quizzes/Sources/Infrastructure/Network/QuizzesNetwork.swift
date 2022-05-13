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
        request.httpMethod = "POST" //set http method as POST
        if let params = params {
//            request.httpBody = convertHeader(with: params)
             let  jsonData = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
             request.httpBody = jsonData//?.base64EncodedData()
         }
        
        // add headers for the request
        request.addValue("application/json", forHTTPHeaderField: "Content-Type") // change as per server requirements
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            print("Data: \(String(describing: data))")
            print("\nError: \(String(describing: error))")
            guard let data = data, error == nil else {
                completion(.failure(.linkNotFound))
                return
            }
        
            do {
                let entities = try JSONDecoder().decode(T.self, from: data)
                print("Entities: \(entities)")
                completion(.success(entities))
            } catch {
                completion(.failure(.defaultError(error)))
            }
        }
        
        task.resume()
    }
}
//
//extension QuizzesNetwork {
//    func convertHeader(with params: [String: Any]) -> Data {
//        return params.data(using: .utf8, allowLossyConversion: false)!
//        )
//        if let jsonData = try? encoder.encode(params) {
//            if let jsonString = String(data: jsonData, encoding: .utf8) {
//                return jsonString.data(using: .utf8) ?? Data()
//            }
//        }
//
//        return Data()
//    }
//}
