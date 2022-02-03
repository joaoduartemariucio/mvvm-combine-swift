//
//  HomeViewController.swift
//  mvvm+combine-swift
//
//  Created by João Vitor Duarte Mariucio on 03/02/22.
//

import Combine
import UIKit

class HomeViewController: UIViewController {

    // MARK: - Type alias

    typealias View = HomeView
    typealias ViewModel = HomeViewModel

    // MARK: - Properties

    let mainView = View()
    let viewModel: ViewModel

    // MARK: - Variables

    @Published var isExampleAllowed: Bool = false
    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Initializers

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle

    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setupViewActions()
    }

    // MARK: - Actions

    @objc
    func didTapButton(_ sender: UIButton) {
        viewModel.changeRandomColor()
    }

    @objc
    func didTapSwitch(_ sender: UISwitch) {
        isExampleAllowed = sender.isOn
        viewModel.changeExampleSwitch(sender.isOn)
    }

    @objc
    func didChangeText(_ sender: UITextField) {
        viewModel.changeText(sender.text)
    }
    // MARK: - Methods
    func bindViewModel() {
        viewModel.$state.sink { [weak self] in
            self?.handleViewModel(state: $0)
        }.store(in: &cancellables)
    }

    func handleViewModel(state: ViewModel.State) {
        switch state {
        case let .updateBackgroudColor(color):
            mainView.backgroundColor = color
        case let .updateLabel(text):
            mainView.exampleLabel.text = text
        default:
            break
        }
    }

    func setupViewActions() {
        $isExampleAllowed
            .receive(on: DispatchQueue.main)
            .assign(to: \.isEnabled, on: mainView.exampleButton)
            .store(in: &cancellables)

        mainView.exampleSwitch.addTarget(self, action: #selector(didTapSwitch(_:)), for: .valueChanged)
        mainView.exampleButton.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        mainView.exampleTextField.addTarget(self, action: #selector(didChangeText(_:)), for: .editingChanged)
    }
}
