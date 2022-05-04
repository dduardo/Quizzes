//
//  QuestionsViewModel.swift
//  Quizzes
//
//  Created by Carlos Eduardo Santiago on 02/05/22.
//

import Foundation

enum QuestionsViewState {
    case loading
    case loaded
    case emptyState
    case error
}

protocol QuestionsViewModelProtocol {
    var questionsViewState: Bindable<QuestionsViewState> { get }
    var model: Bindable<QuestionModel?> { get }

    func fetchQuestions()
}

final class QuestionsViewModel: QuestionsViewModelProtocol {

    // MARK: - Public Vars
    
    internal var questionsViewState = Bindable<QuestionsViewState>(.loading)
    internal var model: Bindable<QuestionModel?> = .init(nil)
    
    // MARK: - Private Vars
    
    private var service: QuizzesNetworkProtocol

    // MARK: - Initialization
    
    public init(with service: QuizzesNetworkProtocol = ProviderMock()) {
        self.service = service
    }
    
    func fetchQuestions() {
        fechQuestionsList()
    }
}

// MARK: - Extensions

extension QuestionsViewModel {
    
    // MARK: - Private Methods

    private func fechQuestionsList() {
        self.questionsViewState.value = .loading

        service.request(endPoint: .questions) { [weak self] (result: NetworkResult<QuestionModel>) in
            guard let self = self else { return }
            switch result {
            case .success(let model):
                self.model.value = model
                self.questionsViewState.value = .loaded
            case .failure(let error):
                print(error)
                self.questionsViewState.value = .error
            }
        }
    }
}
