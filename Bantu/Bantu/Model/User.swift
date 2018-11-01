//
//  User.swift
//  Bantu
//
//  Created by Steven Muliamin on 11/10/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import Foundation

class User {
    var userId: Int
    var levelId: Int
    var fullName: String
    var phone: String
    var email: String
    var password: String
    
    init(userId: Int, levelId: Int, fullName: String, phone: String, email: String, password: String){
        self.userId = userId
        self.levelId = levelId
        self.fullName = fullName
        self.phone = phone
        self.email = email
        self.password = password
    }
}
