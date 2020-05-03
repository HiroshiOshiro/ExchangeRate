//
//  RootRouter.swift
//  CheckExchangeRate
//
//  Created by hiroshi on 2020/05/03.
//  Copyright © 2020 hiroshi. All rights reserved.
//

import UIKit

class RootRouter: RootWireframe {
    func presentTopScreen(in window: UIWindow) {
        window.makeKeyAndVisible()
        window.rootViewController = TopRouter.assembleModule()
    }
}
