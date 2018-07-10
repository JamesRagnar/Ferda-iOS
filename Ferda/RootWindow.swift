//
//  RootWindow.swift
//  Ferda
//
//  Created by James Harquail on 2018-06-06.
//  Copyright © 2018 Ragnar Development. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class RootWindow: UIWindow {

    private let core: CoreType

    private lazy var disposeBag = DisposeBag()

    init(core: CoreType) {
        self.core = core
        super.init(frame: UIScreen.main.bounds)
        bind()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func bind() {
        core.applicationViewModel
            .subscribe(onNext: { [weak self] (viewModel) in
                self?.resetApplicationState(with: viewModel)
            })
            .disposed(by: disposeBag)
    }

    private func resetApplicationState(with viewModel: BaseViewModelType) {
        if let viewModel = viewModel as? StartupViewModelType {
            rootViewController = StartupViewController(viewModel: viewModel)
            return
        }

        if let viewModel = viewModel as? AuthenticationViewModelType {
            rootViewController = AuthenticationViewController(viewModel: viewModel)
            return
        }

        if let viewModel = viewModel as? DashboardViewModelType {
            rootViewController = DashboardViewController(viewModel: viewModel)
            return
        }

        // We have hit an unknown application state
        fatalError()
    }
}
