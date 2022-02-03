//
//  HomeViewModel.swift
//  mvvm+combine-swift
//
//  Created by João Vitor Duarte Mariucio on 03/02/22.
//

import Combine
import Foundation
import UIKit

class HomeViewModel {

    //  MARK: - ViewModel states

    enum State {
        case `default`
        case loading(Bool)
        case updateBackgroudColor(UIColor)
        case updateLabel(String?)
    }

    //  MARK: - Variables

    @Published private(set) var state: State = .default
    var model: HomeModel = .init(exampleText: "", exampleSwitch: false)

    //  MARK: - Methods

    func changeText(_ text: String?) {
        model.exampleText = text ?? ""
        state = .updateLabel(text)
    }

    func changeExampleSwitch(_ value: Bool) {
        model.exampleSwitch = value
    }

    func changeRandomColor() {
        state = .updateBackgroudColor(randomColor())
    }

    func setLoading(_ value: Bool) {
        state = .loading(value)
    }

    private func randomColor() -> UIColor {
        return UIColor(
            red: randomCGFloat(),
            green: randomCGFloat(),
            blue: randomCGFloat(),
            alpha: 1.0
        )
    }

    private func randomCGFloat() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
