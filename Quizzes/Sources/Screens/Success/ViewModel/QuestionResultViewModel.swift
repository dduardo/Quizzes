//
//  QuestionResultViewModel.swift
//  Quizzes
//
//  Created by Carlos Eduardo Santiago on 03/05/22.
//

import Foundation

enum QuestionResultViewState {
    case loading
    case loaded
    case emptyState
    case error
}

protocol QuestionResultViewModelProtocol {
    var questionResultViewState: Bindable<QuestionResultViewState> { get }
    var model: Bindable<QuestionResult?> { get }

    func fetchSuccess()
}

final class QuestionResultViewModel: QuestionResultViewModelProtocol {

    // MARK: - Public Vars
    
    internal var questionResultViewState = Bindable<QuestionResultViewState>(.loading)
    internal var model: Bindable<QuestionResult?> = .init(nil)

    // MARK: - Private Enum

    private enum QuestionResultConstants {
        static let kIdParamKey = "idQuiz"
        static let kResultQuizValueKey = "resultQuizValue"
    }
    
    // MARK: - Private Vars

    private var resultQuiz: ResultQuiz
    private var service: QuizzesNetworkProtocol

    // MARK: - Initialization
    
    public init(with resultQuiz: ResultQuiz = ("0", 0),
                service: QuizzesNetworkProtocol = QuizzesNetwork()) {
        self.resultQuiz = resultQuiz
        self.service = service
    }
    
    // MARK: - Public Methods

    func fetchSuccess() {
        fetchResult()
    }
}

// MARK: - Extensions

extension QuestionResultViewModel {
    
    // MARK: - Private Methods

    private func fetchResult() {
        self.questionResultViewState.value = .loading
            
        let params: [String: Any] = [QuestionResultConstants.kIdParamKey: resultQuiz.0,
                                     QuestionResultConstants.kResultQuizValueKey: resultQuiz.1]

        service.request(endPoint: .result, params: params) { [weak self] (result: NetworkResult<QuestionResult>) in
            guard let self = self else { return }
            switch result {
            case .success(let model):
                self.model.value = model
                self.questionResultViewState.value = .loaded
            case .failure(let error):
                print(error)
                self.questionResultViewState.value = .error
            }
        }
    }
}
