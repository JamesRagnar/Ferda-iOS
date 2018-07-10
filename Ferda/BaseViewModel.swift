//
//  BaseViewModel.swift
//  Ferda
//
//  Created by James Harquail on 2018-06-06.
//  Copyright © 2018 Ragnar Development. All rights reserved.
//

import Foundation
import RxSwift

protocol BaseViewModelType {

}

class BaseViewModel {

    internal lazy var disposeBag = DisposeBag()


    init() {
        bind()
    }

    internal func bind() {

    }
}

extension BaseViewModel: BaseViewModelType {

    
}
