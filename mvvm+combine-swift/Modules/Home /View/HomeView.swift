//
//  HomeView.swift
//  mvvm+combine-swift
//
//  Created by João Vitor Duarte Mariucio on 03/02/22.
//

import UIKit

class HomeView: UIView, ViewCode {

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
        mainStack.addArrangedSubview(mainFillView)
        addSubview(mainStack)
    }

    func setupConstraints() {
        subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            exampleButton.heightAnchor.constraint(equalToConstant: 45),
            exampleTextField.heightAnchor.constraint(equalToConstant: 45)
        ])
    }

    func configureViews() {
        backgroundColor = .white
        exampleLabel.text = "Label example"

        exampleLabel.textAlignment = .center
        exampleSwitchLabel.text = "Switch example observer"

        exampleButton.setTitle("Click example button", for: .normal)
        exampleButton.setBackgroundColor(.blue, for: .normal)
        exampleButton.setBackgroundColor(.gray, for: .disabled)

        exampleTextField.placeholder = "Type something here"
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
