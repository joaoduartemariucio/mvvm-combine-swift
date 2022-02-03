//
//  HomeView.swift
//  mvvm+combine-swift
//
//  Created by João Vitor Duarte Mariucio on 03/02/22.
//

import NVActivityIndicatorView
import UIKit

class HomeView: UIView, ViewCode {

    var isLoading: Bool = false {
        didSet {
            loadingView.isHidden = !isLoading
            isLoading ? indicatorView.startAnimating() : indicatorView.stopAnimating()
        }
    }

    let loadingView = UIView()
    let indicatorView = NVActivityIndicatorView(frame: .init(x: 0, y: 0, width: 60, height: 60), type: .pacman, color: .white, padding: 2)

    let mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.layoutMargins = .init(top: 12, left: 12, bottom: 12, right: 12)
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()

    let mainFillView = UIView()

    let exampleLabel = UILabel()

    let switchStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.layoutMargins = .init(top: 12, left: 12, bottom: 12, right: 12)
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()

    let fillSwitchView = UIView()
    let exampleSwitchLabel = UILabel()
    let exampleSwitch = UISwitch()

    let exampleButton = UIButton()
    let exampleTextField = UITextField()
    let imageLoadingButton = UIButton()
    let exampleImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        applyViewCode()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        applyViewCode()
    }

    func buildHierarchy() {
        mainStack.addArrangedSubview(exampleLabel)
        switchStack.addArrangedSubview(exampleSwitchLabel)
        switchStack.addArrangedSubview(fillSwitchView)
        switchStack.addArrangedSubview(exampleSwitch)
        mainStack.addArrangedSubview(switchStack)
        mainStack.addArrangedSubview(exampleButton)
        mainStack.addArrangedSubview(exampleTextField)
        mainStack.addArrangedSubview(imageLoadingButton)
        mainStack.addArrangedSubview(exampleImageView)
        mainStack.addArrangedSubview(mainFillView)
        addSubview(mainStack)
        loadingView.addSubview(indicatorView)
        addSubview(loadingView)
    }

    func setupConstraints() {
        subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        indicatorView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate(
            [
                mainStack.topAnchor.constraint(equalTo: topAnchor),
                mainStack.leadingAnchor.constraint(equalTo: leadingAnchor),
                mainStack.trailingAnchor.constraint(equalTo: trailingAnchor),
                mainStack.bottomAnchor.constraint(equalTo: bottomAnchor),
                exampleButton.heightAnchor.constraint(equalToConstant: 45),
                imageLoadingButton.heightAnchor.constraint(equalToConstant: 45),
                exampleTextField.heightAnchor.constraint(equalToConstant: 45),
                loadingView.topAnchor.constraint(equalTo: topAnchor),
                loadingView.leadingAnchor.constraint(equalTo: leadingAnchor),
                loadingView.trailingAnchor.constraint(equalTo: trailingAnchor),
                loadingView.bottomAnchor.constraint(equalTo: bottomAnchor),
                indicatorView.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor),
                indicatorView.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor),
                indicatorView.widthAnchor.constraint(equalToConstant: 60),
                indicatorView.heightAnchor.constraint(equalToConstant: 60)
            ]
        )
    }

    func configureViews() {
        backgroundColor = .white
        exampleLabel.text = "Label example"

        exampleLabel.textAlignment = .center
        exampleSwitchLabel.text = "Switch example observer"

        exampleButton.setTitle("Click example button", for: .normal)
        exampleButton.setBackgroundColor(.blue, for: .normal)
        exampleButton.setBackgroundColor(.gray, for: .disabled)

        imageLoadingButton.setTitle("Load image", for: .normal)
        imageLoadingButton.setBackgroundColor(.blue, for: .normal)

        exampleTextField.placeholder = "Type something here"
        loadingView.backgroundColor = UIColor.black.withAlphaComponent(0.70)
        isLoading = false
    }
}

extension UIButton {

    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        clipsToBounds = true
        setBackgroundImage(image(withColor: color), for: state)
    }

    private func image(withColor color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()

        context?.setFillColor(color.cgColor)
        context?.fill(rect)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image
    }
}
