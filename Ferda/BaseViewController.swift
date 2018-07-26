//
//  BaseViewController.swift
//  Ferda
//
//  Created by James Harquail on 2018-06-01.
//  Copyright © 2018 Ragnar Development. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class BaseViewController: UIViewController, NavigatorType {

    internal lazy var disposeBag = DisposeBag()

    private var loadingModal: UIAlertController = {
        let alert = UIAlertController(title: nil,
                                      message: "Working on it...",
                                      preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10,
                                                                     y: 5,
                                                                     width: 50,
                                                                     height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = .gray
        loadingIndicator.startAnimating()

        alert.view.addSubview(loadingIndicator)

        return alert
    }()

    public init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()

        view.backgroundColor = .gray
    }

    internal func bind(_ viewModel: ScreenModelType) {
        viewModel.injectNavigator(self)
    }

    private func showErrorModal(with model: ErrorModalViewModelType) {
        let alertModal = UIAlertController(title: nil,
                                           message: model.errorDetail,
                                           preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK",
                                     style: .default,
                                     handler: nil)
        alertModal.addAction(okAction)

        present(alertModal, animated: true)
    }

    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        if presentedViewController != nil {
            dismiss(animated: false) {
                super.present(viewControllerToPresent,
                              animated: true,
                              completion: nil)
            }
        } else {
            super.present(viewControllerToPresent,
                          animated: true,
                          completion: nil)
        }
    }

    // MARK: NavigatorType

    func navigateBack() -> Bool {
        return navigationController?.popViewController(animated: true) != nil
    }

    func navigate(to screenModel: ScreenModelType) -> Bool {
        return false
    }

    func present(modal viewModel: ModalViewModelType) {
        if let _ = viewModel as? LoadingModalViewModelType {
            showLoadingModal()
            return
        }

        if let viewModel = viewModel as? ErrorModalViewModelType {
            showErrorModal(with: viewModel)
            return
        }
    }

    func showLoadingModal() {
        present(loadingModal, animated: true)
    }

    func hideLoadingModal() {
        if presentedViewController == loadingModal {
            dismiss(animated: true, completion: nil)
        }
    }
}
