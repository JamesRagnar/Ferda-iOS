//
//  User.swift
//  Ferda
//
//  Created by James Harquail on 2018-07-20.
//  Copyright © 2018 Ragnar Development. All rights reserved.
//

import Foundation
import Firebase

protocol UserType {

    var email: String? { get }
}

class User {

    
}

extension User: UserType {

    var email: String? {
        return nil
    }
}
