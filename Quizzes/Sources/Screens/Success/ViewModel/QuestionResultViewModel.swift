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
    
    // MARK: - Private Vars
    
    private var service: QuizzesNetworkProtocol

    // MARK: - Initialization
    
    public init(with service: QuizzesNetworkProtocol = ProviderMock()) {
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

        service.request(endPoint: .result) { [weak self] (result: NetworkResult<QuestionResult>) in
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
