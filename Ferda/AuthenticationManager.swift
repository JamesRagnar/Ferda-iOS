//
//  AuthenticationManager.swift
//  Ferda
//
//  Created by James Harquail on 2018-05-27.
//  Copyright © 2018 Ragnar Development. All rights reserved.
//

import Foundation
import RxSwift
import FirebaseAuth

enum AuthenticationState {
    case none
    case unauthorized
    case authorized
}

protocol AuthenticationManagerType {

    var authenticationState: Observable<AuthenticationState> { get }

    func login(with email: String, password: String) -> Completable
    func signUp(with email: String, password: String) -> Completable
    func logOut()
}

class AuthenticationManager {

    private lazy var authenticationStateSubject = BehaviorSubject<AuthenticationState>(value: .none)

    init() {
        // Observe auth state changes
        Auth.auth()
            .addStateDidChangeListener { [weak self] (auth, user) in
                guard let this = self else {
                    return
                }

                if let _ = user {
                    this.authenticationStateSubject.onNext(.authorized)
                } else {
                    this.authenticationStateSubject.onNext(.unauthorized)
                }
        }
    }
}

extension AuthenticationManager: AuthenticationManagerType {

    var authenticationState: Observable<AuthenticationState> {
        return authenticationStateSubject.asObservable()
    }

    func login(with email: String, password: String) -> Completable {
        return Completable
            .create(subscribe: { (completable) -> Disposable in
                Auth.auth()
                    .signIn(withEmail: email, password: password) { (user, error) in
                        if let error = error {
                            completable(.error(error))
                            return
                        }

                        completable(.completed)
                }
                return Disposables.create()
            })
    }

    func signUp(with email: String, password: String) -> Completable {
        return Completable
            .create(subscribe: { (completable) -> Disposable in
                Auth.auth()
                    .createUser(withEmail: email, password: password) { (authResult, error) in
                        if let error = error {
                            completable(.error(error))
                            return
                        }

                        completable(.completed)
                }
                return Disposables.create()
            })
    }

    func logOut() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
}
