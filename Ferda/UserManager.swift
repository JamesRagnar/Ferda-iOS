//
//  UserManager.swift
//  Ferda
//
//  Created by James Harquail on 2018-07-20.
//  Copyright © 2018 Ragnar Development. All rights reserved.
//

import Foundation
import RxSwift
import Firebase

protocol UserManagerType {

    func syncCurrentUser(with auth: Auth)
}

class UserManager {

    private lazy var user = Variable<UserType?>(nil)
    private lazy var disposeBag = DisposeBag()

}

extension UserManager: UserManagerType {

    func syncCurrentUser(with auth: Auth) {

    }
}
