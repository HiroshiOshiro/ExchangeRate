//
//  UserPreferenceData.swift
//  CheckExchangeRate
//
//  Created by hiroshi on 2020/05/03.
//  Copyright © 2020 hiroshi. All rights reserved.
//

import RealmSwift

class UserPreferenceData: Object {
    @objc dynamic var fromCurrency: String = "USD"
    @objc dynamic var toCurrency: String = "JPY"
}
