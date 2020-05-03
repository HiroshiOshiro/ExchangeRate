//
//  TopPresenter.swift
//  CheckExchangeRate
//
//  Created by hiroshi on 2020/05/02.
//  Copyright © 2020 hiroshi. All rights reserved.
//

import Foundation

class TopPresenter: TopPresentation {
    
    weak var view: TopView?
    var interactor: TopUseCase!
    var router: TopWireframe!
    
    
    func viewDidLoad() {
        print("viewDidLoad")
    }
    
    
}

extension TopPresenter: TopInteractorOutput {
    
}

