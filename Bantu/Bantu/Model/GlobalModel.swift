//
//  GlobalModel.swift
//  Bantu
//
//  Created by Steven Muliamin on 11/10/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import Foundation

struct GlobalSession{
    static let session = URLSession(configuration: .default)
    static var rootUrl = "https://bantuapp.online/public"
    static var loggedInUser: User!
    static var isLoggedIn: Bool = false
    
    static var submissions: [Post] = []
    static var initialLogin: Bool = true
}

struct AddDraft {
    static var onDraft: Bool = false
    static var selectedIndex: Int!
    static var needs: [Needs] = []
}
