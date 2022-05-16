//
//  QuestionsViewModel.swift
//  Quizzes
//
//  Created by Carlos Eduardo Santiago on 02/05/22.
//

import Foundation

typealias ResultQuiz = (idQuiz: String, sumAnswers: Int)

enum QuestionsCallBack {
    case succeed(ResultQuiz)
    case didNotAnswerAll
}

enum QuestionsViewState {
    case loading
    case loaded
    case emptyState
    case error
}

protocol QuestionsViewModelProtocol {
    var completionQuiz: Bindable<QuestionsCallBack?> { get }
    var questionsViewState: Bindable<QuestionsViewState> { get }
    var model: Bindable<QuestionModel?> { get }

    func fetchQuestions()
    func addChosenItem(with id: String, answerValue: Int)
    func checkQuiz()
}

final class QuestionsViewModel: QuestionsViewModelProtocol {

    // MARK: - Public Vars
    
    internal var questionsViewState = Bindable<QuestionsViewState>(.loading)
    internal var model: Bindable<QuestionModel?> = .init(nil)
    internal var completionQuiz: Bindable<QuestionsCallBack?> = .init(nil)
    
    // MARK: - Private Enum

    private enum QuestionsConstants {
        static let kParamKey = "idQuizHome"
    }
    
    // MARK: - Private Vars
    
    private var pageIndex: Int = 0
    private var selectedItens: [String: Int] = [:]
    
    // MARK: - Private Vars

    private var idQuizHome: String = String()
    private var service: QuizzesNetworkProtocol

    // MARK: - Initialization
    
    public init(with idQuizHome: String = String(), service: QuizzesNetworkProtocol = QuizzesNetwork()) {
        self.idQuizHome = idQuizHome
        self.service = service
    }
    
    func fetchQuestions() {
        fechQuestionsList()
    }
    
    func addChosenItem(with id: String, answerValue: Int) {
        if selectedItens.index(forKey: id) == nil {
            selectedItens.updateValue(answerValue, forKey: id)
        } else {
            selectedItens[id] = answerValue
        }
    }
    
    func checkQuiz() {
        if selectedItens.count == model.value?.data?.questions.count {
            guard let idQuiz = model.value?.data?.idQuiz else { return }
            completionQuiz.value = .succeed((idQuiz: idQuiz, sumAnswers: sumValues()))
        } else {
            completionQuiz.value = .didNotAnswerAll
        }
    }
    
    private func sumValues() -> Int {
        return selectedItens.compactMap({ $0.value }).reduce(0, +)
    }
}

// MARK: - Extensions

extension QuestionsViewModel {
    
    // MARK: - Private Methods

    private func fechQuestionsList() {
        model.value = nil
        self.questionsViewState.value = .loading
        let params = [QuestionsConstants.kParamKey: idQuizHome]

        service.request(endPoint: .questions, params: params) { [weak self] (result: NetworkResult<QuestionModel>) in
            guard let self = self else { return }
            switch result {
            case .success(let model):
                self.model.value = model
                self.questionsViewState.value = .loaded
            case .failure(let error):
                self.questionsViewState.value = .error
            }
        }
    }
}
