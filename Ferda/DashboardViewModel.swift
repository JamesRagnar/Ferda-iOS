//
//  DashboardViewModel.swift
//  Ferda
//
//  Created by James Harquail on 2018-06-06.
//  Copyright © 2018 Ragnar Development. All rights reserved.
//

import Foundation

protocol DashboardViewModelType: ScreenModelType {

    func logout()
}

class DashboardViewModel: ScreenModel {

    private let authenticationManager: AuthenticationManager

    init(authenticationManager: AuthenticationManager) {
        self.authenticationManager = authenticationManager
    }
}

extension DashboardViewModel: DashboardViewModelType {

    func logout() {
        authenticationManager.logOut()
    }
}
