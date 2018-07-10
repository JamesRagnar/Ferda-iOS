//
//  AuthenticationViewModel.swift
//  Ferda
//
//  Created by James Harquail on 2018-06-06.
//  Copyright © 2018 Ragnar Development. All rights reserved.
//

import Foundation
import RxSwift

protocol AuthenticationViewModelType: ScreenModelType {

    typealias RegistrationInput = (email: String, password: String)

    func validateRegistrationInput(_ email: String?, password: String?) -> RegistrationInput?
    func login(_ input: RegistrationInput)
    func register(_ input: RegistrationInput)
}

class AuthenticationViewModel: ScreenModel {

    private let authenticationManager: AuthenticationManager

    init(authenticationManager: AuthenticationManager) {
        self.authenticationManager = authenticationManager
    }
}

extension AuthenticationViewModel: AuthenticationViewModelType {

    func validateRegistrationInput(_ email: String?, password: String?) -> RegistrationInput? {
        guard let email = email, email.count > 0 else {
            navigator?.present(modal: ErrorModalViewModel(description: "No Email"))
            return nil
        }

        guard let password = password, password.count > 0 else {
            navigator?.present(modal: ErrorModalViewModel(description: "No Password"))
            return nil
        }

        // Check email string is valid
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        guard emailPredicate.evaluate(with: email) else {
            navigator?.present(modal: ErrorModalViewModel(description: "Invalid Email"))
            return nil
        }

        // Check password string is valid
        guard password.count >= 6 else {
            navigator?.present(modal: ErrorModalViewModel(description: "Invalid Password"))
            return nil
        }

        return (email, password)
    }

    func login(_ input: RegistrationInput) {
        navigator?.showLoadingModal()

        authenticationManager
            .login(with: input.email, password: input.password)
            .subscribe(onCompleted: { [weak self] in
                self?.navigator?.hideLoadingModal()
                }, onError: { [weak self] (error) in
                    self?.navigator?.present(modal: ErrorModalViewModel(description: "Login Error:\n\(error.localizedDescription)"))
            })
            .disposed(by: disposeBag)
    }

    func register(_ input: RegistrationInput) {
        navigator?.showLoadingModal()

        authenticationManager
            .signUp(with: input.email, password: input.password)
            .subscribe(onCompleted: { [weak self] in
                self?.navigator?.hideLoadingModal()
                }, onError: { [weak self] (error) in
                    self?.navigator?.present(modal: ErrorModalViewModel(description: "Registration Error:\n\(error.localizedDescription)"))
            })
            .disposed(by: disposeBag)
    }
}
