//
//  CurrencyListResponse.swift
//  CheckExchangeRate
//
//  Created by hiroshi on 2020/05/03.
//  Copyright © 2020 hiroshi. All rights reserved.
//

import Foundation

struct CurrencyListResponse: Codable {
    let success: Bool
    let currencies: [String: String]
}
