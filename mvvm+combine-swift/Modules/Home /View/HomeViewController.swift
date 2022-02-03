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
    @Published var exampleText: String?

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

    func didTapButton() {
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

    @objc
    func didTapButtonLoadImage(_ sender: UITextField) {
        loadImageExample()
    }

    // MARK: - Methods

    func bindViewModel() {
        viewModel.$state.sink { [weak self] in
            self?.handleViewModel(state: $0)
        }.store(in: &cancellables)
    }

    func handleViewModel(state: ViewModel.State) {
        switch state {
        case let .loading(isLoading):
            mainView.isLoading = isLoading
        case let .updateBackgroudColor(color):
            mainView.backgroundColor = color
        case let .updateLabel(text):
            exampleText = text ?? "Example text"
        default:
            break
        }
    }

    func setupViewActions() {
        $isExampleAllowed
            .receive(on: DispatchQueue.main)
            .assign(to: \.isEnabled, on: mainView.exampleButton)
            .store(in: &cancellables)

        $exampleText
            .receive(on: DispatchQueue.main)
            .assign(to: \.text, on: mainView.exampleLabel)
            .store(in: &cancellables)

        mainView.exampleButton
            .publisher(for: .touchUpInside)
            .sink {[weak self] _ in
                self?.didTapButton()
            }.store(in: &cancellables)

        mainView.exampleSwitch.addTarget(self, action: #selector(didTapSwitch(_:)), for: .valueChanged)
        mainView.imageLoadingButton.addTarget(self, action: #selector(didTapButtonLoadImage(_:)), for: .touchUpInside)
        mainView.exampleTextField.addTarget(self, action: #selector(didChangeText(_:)), for: .editingChanged)
    }

    func loadImageExample() {
        viewModel.setLoading(true)
        guard let url = URL(string: "https://picsum.photos/300/600") else {
            viewModel.setLoading(false)
            return
        }
        URLSession.shared
            .dataTaskPublisher(for: url)
            .map(\.data)
            .compactMap(UIImage.init)
            .receive(on: RunLoop.main, options: nil)
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.viewModel.setLoading(false)
            } receiveValue: { [weak self] image in
                guard let self = self else { return }
                self.mainView.exampleImageView.image = image
            }.store(in: &cancellables)
    }
}
