//
//  AuthenticationViewController.swift
//  Ferda
//
//  Created by James Harquail on 2018-05-27.
//  Copyright © 2018 Ragnar Development. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

class AuthenticationViewController: BaseViewController {

    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.placeholder = "email"
        textField.keyboardType = .emailAddress
        textField.returnKeyType = .next
        textField.autocapitalizationType = .none
        textField.delegate = self
        return textField
    }()

    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.placeholder = "password"
        textField.isSecureTextEntry = true
        textField.returnKeyType = .next
        textField.autocapitalizationType = .none
        textField.delegate = self
        return textField
    }()

    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self,
                         action: #selector(loginButtonTapped),
                         for: .touchUpInside)
        return button
    }()

    private lazy var registerButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Register", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self,
                         action: #selector(registerButtonTapped),
                         for: .touchUpInside)
        return button
    }()

    private let viewModel: AuthenticationViewModelType

    init(viewModel: AuthenticationViewModelType) {
        self.viewModel = viewModel
        super.init()
        bind(viewModel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()

        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(registerButton)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        let fieldSize = CGSize(width: view.frame.width - 40, height: 40)

        emailTextField.frame.size = fieldSize
        emailTextField.frame.origin.x = 20
        emailTextField.frame.origin.y = view.safeAreaInsets.top + 20

        passwordTextField.frame.size = fieldSize
        passwordTextField.frame.origin.x = 20
        passwordTextField.frame.origin.y = emailTextField.frame.maxY + 20

        loginButton.frame.size = fieldSize
        loginButton.frame.origin.x = 20
        loginButton.frame.origin.y = passwordTextField.frame.maxY + 20

        registerButton.frame.size = fieldSize
        registerButton.frame.origin.x = 20
        registerButton.frame.origin.y = loginButton.frame.maxY + 20
    }

    typealias BaseViewModelType = AuthenticationViewModelType

    @objc private func loginButtonTapped() {
        if let input = viewModel.validateRegistrationInput(emailTextField.text, password: passwordTextField.text) {
            viewModel.login(input)
        }
    }

    @objc private func registerButtonTapped() {
        if let input = viewModel.validateRegistrationInput(emailTextField.text, password: passwordTextField.text) {
            viewModel.register(input)
        }
    }
}

extension AuthenticationViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            emailTextField.becomeFirstResponder()
        }

        return false
    }
}
