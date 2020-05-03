//
//  Define.swift
//  CheckExchangeRate
//
//  Created by hiroshi on 2020/05/03.
//  Copyright © 2020 hiroshi. All rights reserved.
//

import Foundation

struct Define {
    static let defaultFromCurrency = "USD"
    static let defaultToCurrency = "JPY"
    static let AccessKey = "7789da114bc58a0ba1562914d0f2f20e"
    static let getCurrencyListAPIPath = "http://api.currencylayer.com/list?access_key=" + AccessKey
    static let getRateAPIPath = "http://api.currencylayer.com/live?access_key=" + AccessKey
}
