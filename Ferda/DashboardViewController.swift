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

    private lazy var logoutButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Logout",
                                     style: .plain,
                                     target: self,
                                     action: #selector(logoutButtonTapped))
        return button
    }()

    private lazy var addContactButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Add Contact",
                                     style: .plain,
                                     target: self,
                                     action: #selector(addContactButtonTapped))
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

        navigationItem.leftBarButtonItem = logoutButton
        navigationItem.rightBarButtonItem = addContactButton
    }

    @objc private func logoutButtonTapped() {
        viewModel.logout()
    }

    @objc private func addContactButtonTapped() {
        viewModel.showAddContactView()
    }

    override func navigate(to screenModel: ScreenModelType) -> Bool {
        if super.navigate(to: screenModel) {
            return false
        }

        if let addContactViewModel = screenModel as? AddContactViewModelType {
            let addContactViewController = AddContactViewController(viewModel: addContactViewModel)
            navigationController?.pushViewController(addContactViewController, animated: true)
            return true
        }

        return false
    }
}
