//
//  Core.swift
//  Ferda
//
//  Created by James Harquail on 2018-05-27.
//  Copyright © 2018 Ragnar Development. All rights reserved.
//

import Foundation
import RxSwift

enum ApplicationState {
    case loading
    case unauthorized
    case running
}

protocol CoreType {

    var applicationViewModel: Observable<BaseViewModelType> { get }
}

class Core {

    private lazy var authenticationManager = AuthenticationManager()
}

extension Core: CoreType {

    var applicationViewModel: Observable<BaseViewModelType> {
        return authenticationManager
            .authenticationState
            .map({ (authenticationState) -> BaseViewModel in
                switch authenticationState {
                case .none:
                    return StartupViewModel()
                case .unauthorized:
                    return AuthenticationViewModel(authenticationManager: self.authenticationManager)
                case .authorized:
                    return DashboardViewModel(authenticationManager: self.authenticationManager)
                }
            })
    }
}
