//
//  ModalViewModel.swift
//  Ferda
//
//  Created by James Harquail on 2018-07-06.
//  Copyright © 2018 Ragnar Development. All rights reserved.
//

import Foundation

protocol ModalViewModelType {

    // If the modal can be dismissed without user input
    var isDismissable: Bool { get }
}

class ModalViewModel: BaseViewModel, ModalViewModelType {

    public lazy var isDismissable = true
}

protocol LoadingModalViewModelType: ModalViewModelType {


}

class LoadingModalViewModel: ModalViewModel, LoadingModalViewModelType {

}

protocol ErrorModalViewModelType: ModalViewModelType {

    var errorDetail: String { get }
}

class ErrorModalViewModel: ModalViewModel, ErrorModalViewModelType {

    public let errorDetail: String

    init(error: Error) {
        self.errorDetail = error.localizedDescription
        super.init()
        // Modal has to be dimsissed with user input
        isDismissable = false
    }

    init(description: String?) {
        self.errorDetail = description ?? "Error"
        super.init()
    }
}
