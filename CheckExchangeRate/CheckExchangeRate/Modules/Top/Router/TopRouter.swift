//
//  TopRouter.swift
//  CheckExchangeRate
//
//  Created by hiroshi on 2020/05/02.
//  Copyright © 2020 hiroshi. All rights reserved.
//

import UIKit

class TopRouter: TopWireframe {
    weak var viewController: UIViewController?
    
    private init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    static func assembleModule() -> UIViewController {
        
        guard let view = R.storyboard.top.topViewController() else {
            return UIViewController()
        }
        
        let presenter = TopPresenter()
        let interactor = TopInteractor()
        let router = TopRouter(viewController: view)

        view.presenter = presenter

        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router

        interactor.output = presenter

        router.viewController = view

        return view
    }
}
