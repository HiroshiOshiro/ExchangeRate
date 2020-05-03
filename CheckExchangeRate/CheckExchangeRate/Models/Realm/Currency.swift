//
//  Currency.swift
//  CheckExchangeRate
//
//  Created by hiroshi on 2020/05/03.
//  Copyright © 2020 hiroshi. All rights reserved.
//

import RealmSwift

//class CurrencyData: Object {
//    @objc dynamic var createdAt = Date()
//    let currencies = List<Currency>()
//}

class Currency: Object {
    @objc dynamic var code: String = ""
    @objc dynamic var fullname: String = ""
        
    override static func primaryKey() -> String? {
        return "code"
    }
}
