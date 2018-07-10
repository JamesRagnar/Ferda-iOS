//
//  DashboardViewController.swift
//  Ferda
//
//  Created by James Harquail on 2018-05-27.
//  Copyright © 2018 Ragnar Development. All rights reserved.
//

import Foundation
import UIKit

class DashboardViewController: BaseViewController {

    private lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Logout", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self,
                         action: #selector(logoutButtonTapped),
                         for: .touchUpInside)
        return button
    }()

    private let viewModel: DashboardViewModelType

    init(viewModel: DashboardViewModelType) {
        self.viewModel = viewModel
        super.init()
        bind(viewModel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()

        view.backgroundColor = .gray

        view.addSubview(logoutButton)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        let fieldSize = CGSize(width: view.frame.width - 40, height: 40)

        logoutButton.frame.size = fieldSize
        logoutButton.frame.origin.x = 20
        logoutButton.frame.origin.y = view.safeAreaInsets.top + 20
    }

    @objc private func logoutButtonTapped() {
        viewModel.logout()
    }
}
