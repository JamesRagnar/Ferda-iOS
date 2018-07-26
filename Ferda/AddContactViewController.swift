//
//  AddContactViewController.swift
//  Ferda
//
//  Created by James Harquail on 2018-07-20.
//  Copyright © 2018 Ragnar Development. All rights reserved.
//

import Foundation
import UIKit

class AddContactViewController: BaseViewController {

    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.placeholder = "User Email"
        return searchBar
    }()

    private let viewModel: AddContactViewModelType

    init(viewModel: AddContactViewModelType) {
        self.viewModel = viewModel
        super.init()
        bind(viewModel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()

        navigationItem.titleView = searchBar
    }

    @objc private func cancelButtonTapped() {

    }
}
