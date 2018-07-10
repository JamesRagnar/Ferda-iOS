//
//  StartupViewController.swift
//  Ferda
//
//  Created by James Harquail on 2018-06-01.
//  Copyright © 2018 Ragnar Development. All rights reserved.
//

import Foundation
import UIKit

class StartupViewController: BaseViewController {

    private let viewModel: StartupViewModelType

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(viewModel: StartupViewModelType) {
        self.viewModel = viewModel
        super.init()
        bind(viewModel)
    }

    override func loadView() {
        super.loadView()

        view.backgroundColor = .gray
    }
}
