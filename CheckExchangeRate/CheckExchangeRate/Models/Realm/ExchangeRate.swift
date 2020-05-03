//
//  ExchangeRate.swift
//  CheckExchangeRate
//
//  Created by hiroshi on 2020/05/03.
//  Copyright © 2020 hiroshi. All rights reserved.
//

import RealmSwift

class ExchangeRate: Object {
    @objc dynamic var timestamp: Int = 0
    @objc dynamic var source: String = ""
    var quotes: [String: Double] = ["": 0.0]
}


