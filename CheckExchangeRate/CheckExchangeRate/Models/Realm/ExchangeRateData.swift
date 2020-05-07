//
//  ExchangeRate.swift
//  CheckExchangeRate
//
//  Created by hiroshi on 2020/05/03.
//  Copyright © 2020 hiroshi. All rights reserved.
//

import RealmSwift

class ExchangeRateData: Object {
    @objc dynamic var timestamp: Int = 0
    @objc dynamic var savedAt: Date?
    @objc dynamic var source: String = ""
    var quotes = List<Rate>()
}

class Rate: Object {
    @objc dynamic var code: String = ""
    @objc dynamic var rate: Double = 0.0
        
    override static func primaryKey() -> String? {
        return "code"
    }
}


