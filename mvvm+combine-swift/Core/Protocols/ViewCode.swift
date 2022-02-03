//
//  ViewCode.swift
//  mvvm+combine-swift
//
//  Created by João Vitor Duarte Mariucio on 03/02/22.
//

import Foundation

public protocol ViewCode {
    /// Use this method to add your views
    func buildHierarchy()
    /// Use this method to add constraints to your views
    func setupConstraints()
    /// Use this method to configure your visualization settings such as adding text to a Label, setting images etc.
    func configureViews()
    /// This method applies all the settings of the other methods
    func applyViewCode()
}

public extension ViewCode {

    func applyViewCode() {
        buildHierarchy()
        setupConstraints()
        configureViews()
    }
}
