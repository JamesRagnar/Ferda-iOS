//
//  BaseScreenModel.swift
//  Ferda
//
//  Created by James Harquail on 2018-07-06.
//  Copyright © 2018 Ragnar Development. All rights reserved.
//

import Foundation
import RxSwift

protocol NavigatorType {

    func navigateBack() -> Bool
    func navigate(to screenModel: ScreenModelType) -> Bool

    func present(modal viewModel: ModalViewModelType)
    func showLoadingModal()
    func hideLoadingModal()
}

protocol ScreenModelType {

    func injectNavigator(_ navigator: NavigatorType?)
}

class ScreenModel: BaseViewModel {

    var navigator: NavigatorType?
}

extension ScreenModel: ScreenModelType {

    func injectNavigator(_ navigator: NavigatorType?) {
        self.navigator = navigator
    }
}
