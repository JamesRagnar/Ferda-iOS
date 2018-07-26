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
    func showAddContactView()
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

    func showAddContactView() {
        let addContactViewModel = AddContactViewModel()
        _ = navigator?.navigate(to: addContactViewModel)
    }
}
