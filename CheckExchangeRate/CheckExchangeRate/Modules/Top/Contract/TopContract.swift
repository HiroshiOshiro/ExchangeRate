//
//  TopContract.swift
//  CheckExchangeRate
//
//  Created by hiroshi on 2020/05/02.
//  Copyright © 2020 hiroshi. All rights reserved.
//

import UIKit

protocol TopView: class {
    
}

protocol TopPresentation: class {
    var view: TopView? { get set }
    var interactor: TopUseCase! { get set }
    var router: TopWireframe! { get set }
    
    func viewDidLoad()
}

protocol TopUseCase: class {
}

protocol TopInteractorOutput: class {
    
}

protocol TopWireframe: class {
    
}
