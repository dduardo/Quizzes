//
//  QuizHomeViewModel.swift
//  Quizzes
//
//  Created by Carlos Eduardo Santiago on 02/05/22.
//

import Foundation

enum HomeViewState {
    case loading
    //Remover model
    case loaded(QuizHeadlineModel)
    case emptyState
    case error
}

protocol QuizHomeViewModelProtocol {
//    var getResponseCallBack: Bindable<GetHomeQuizzesCallBack?> { get }
    var homeViewState: Bindable<HomeViewState> { get }
    var model: Bindable<QuizHeadlineModel?> { get }
    
    func fetchList()
}

final class QuizHomeViewModel: QuizHomeViewModelProtocol {

    // MARK: - Public Vars
    
    internal var homeViewState = Bindable<HomeViewState>(.loading)
    internal var model: Bindable<QuizHeadlineModel?> = .init(nil)
    
    // MARK: - Private Vars
    
    private var service: QuizzesNetworkProtocol

    // MARK: - Initialization
    
    public init(with service: QuizzesNetworkProtocol = ProviderMock()) {
        self.service = service
    }
    
    func fetchList() {
        fechQuizList()
    }
}

// MARK: - Extensions

extension QuizHomeViewModel {
    
    // MARK: - Private Methods

    private func fechQuizList() {
        self.homeViewState.value = .loading

        service.request(endPoint: .quizHome) { [weak self] (result: NetworkResult<QuizHeadlineModel>) in
            guard let self = self else { return }
            switch result {
            case .success(let model):
                self.model.value = model
                self.homeViewState.value = .loaded(model)
            case .failure:
                self.homeViewState.value = .error
            }
        }
    }
}
