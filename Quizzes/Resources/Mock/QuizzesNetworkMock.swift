//
//  QuizzesNetworkMock.swift
//  Quizzes
//
//  Created by Carlos Eduardo Santiago on 02/05/22.
//

import Foundation

class QuizzesNetworkMock: QuizzesNetworkProtocol {
    
    var delaySeconds: TimeInterval
    var links: [Links: Data]?
    
    public init(delaySeconds: TimeInterval = 0) {
        self.delaySeconds = delaySeconds
    }
    
    convenience init (delaySeconds: TimeInterval = 0, links: [Links: Data]?) {
        self.init(delaySeconds: delaySeconds)
        self.links = links
    }
    
    func request<T>(endPoint: Links, params: Dictionary<String, Any>?, completion: @escaping CompletionDataCallback<T>) where T : Decodable {
        requestMock(link: endPoint.rawValue, completion: completion)
    }
    
    private func requestMock<T: Decodable>(link: String,
                                           completion: @escaping CompletionDataCallback<T>) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delaySeconds) { [weak self] in
            guard let linkValue = Links(rawValue: link) else {
                print("🚨🚨🚨 LINK NOT FOUND: \(link)")
                completion(.failure(.linkNotFound))
                return
            }
            
            var mappedJsonData = self?.getMappedJsonData(for: linkValue)
            
            if mappedJsonData == nil {
                mappedJsonData = self?.getDefaultJsonData(for: linkValue)
            }
            
            guard let jsonData = mappedJsonData else {
                print("🚨🚨🚨 EMPTY DATA")
                completion(.failure(.emptyData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decoded = try decoder.decode(T.self, from: jsonData)
                completion(.success(decoded))
            } catch {
                print("🚨🚨🚨 DECODE ERROR: \(error)")
                completion(.failure(.defaultError(error)))
            }
        }
    }
    
    private func getMappedJsonData(for link: Links) -> Data? {
        guard let jsonData = links?[link] else { return nil}
        return jsonData
    }
    
    private func getDefaultJsonData(for link: Links) -> Data {
        switch link {
        case .quizHome:
            return getQuizzesHome
        case .questions:
            return postQuestions
        case .result:
            return postResult
        }
    }
}
