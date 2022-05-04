//
//  QuizHomeViewController.swift
//  Quizzes
//
//  Created by Carlos Eduardo Santiago on 29/04/22.
//

import UIKit

final class QuizHomeViewController: UIViewController {

//    var detailsCallback: ((String, FormalizationTypes) -> Void)?
//    var erroCallback: ((GenericErrorTypes, (() -> Void)?) -> Void)?
    var cellDidTapeped: ((String) -> Void)?

    // MARK - Private Properties

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(QuizCell.self, forCellReuseIdentifier: "QuizCell")
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .singleLine

        return tableView
    }()

    private var viewModel: QuizHomeViewModelProtocol
    
    // MARK - Override and Initializers
    
    public init(with viewModel: QuizHomeViewModelProtocol = QuizHomeViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Quizzes"
        
        setupUI()
        bindViewModel()
        viewModel.fetchList()
    }

    // MARK: - Bind View Model

    private func bindViewModel() {
//        bindShimmerLoading()
        bindGetResponseCallBack()
//        bindButtonLoading()
//        bindPostReponseCallBack()
    }

    private func bindGetResponseCallBack() {
        viewModel.homeViewState.bind(skip: true) { [unowned self] value in
            switch value {
            case .loading:
                break
            case .loaded(let model):
                self.handleSuccess(with: model)
            case .error:
                break
            default:
                break
            }
        }
    }

    // MARK - Private Methods

    private func setupUI() {
        view.backgroundColor = .white

        setupTableView()
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self

        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension QuizHomeViewController {
    
    private func handleSuccess(with model: QuizHeadlineModel) {
        tableView.reloadData()
    }
}

// MARK - Extension UITableViewDataSource & UITableViewDelegate

extension QuizHomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cellDidTapeped?("asd")
    }
}

extension QuizHomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
         return 1
     }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.model.value?.quizList.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let modelCell = viewModel.model.value?.quizList[indexPath.row], let cell = tableView.dequeueReusableCell(withIdentifier: "QuizCell", for: indexPath) as? QuizCell {
            cell.setup(with: modelCell)
            return cell
        }
        return UITableViewCell()
    }
}
