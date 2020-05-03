//
//  LiveRateResponse.swift
//  CheckExchangeRate
//
//  Created by hiroshi on 2020/05/04.
//  Copyright © 2020 hiroshi. All rights reserved.
//

import Foundation

struct RateListResponse: Codable {
    let success: Bool
    
    let timestamp: Int
    let source: String
    let quotes: [String: Double]
}
