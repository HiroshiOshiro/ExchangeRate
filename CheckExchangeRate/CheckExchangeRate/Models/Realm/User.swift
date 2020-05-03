//
//  UserInfo.swift
//  CheckExchangeRate
//
//  Created by hiroshi on 2020/05/02.
//  Copyright © 2020 hiroshi. All rights reserved.
//

import RealmSwift

class User: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var birthDay: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
