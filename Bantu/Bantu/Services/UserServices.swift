//
//  UserServices.swift
//  Bantu
//
//  Created by Steven Muliamin on 11/10/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import Foundation

struct UserServices {
    static func postUser(newUser: User, onComplete: @escaping (Bool) -> ()){
        
        let newUrlString = GlobalSession.rootUrl + "/users/"
        let url = URL(string: newUrlString)
        
        var urlRequest = URLRequest.init(url: url!)
        urlRequest.httpMethod = "POST"
        
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonInput = [
            "levelId": newUser.levelId,
            "fullName": newUser.fullName,
            "phone": newUser.phone,
            "email": newUser.email,
            "password": newUser.password
            ] as [String : Any]
        let data = try? JSONSerialization.data(withJSONObject: jsonInput, options: [])
        
        urlRequest.httpBody = data
        let dataTask = GlobalSession.session.dataTask(with: urlRequest) { (data, response, error) in
            if let unwrappedError = error {
                print("Error = \(unwrappedError.localizedDescription)")
                onComplete(false)
            } else if let unwrappedData = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: unwrappedData, options: [])
                    if let dictionary = json as? [String:Any] {
                        print(dictionary)
                        onComplete(true)
                    }
                } catch {
                }
            }
        }
        dataTask.resume()
    }
    
    static func getUsers(onComplete: @escaping ([User])->()){
        let newUrlString = GlobalSession.rootUrl + "/users/"
        let url = URL(string: newUrlString)
        
        let dataTask = GlobalSession.session.dataTask(with: url!) { (data, response, error) in

            if let unwrappedError = error {
                print("Error = \(unwrappedError.localizedDescription)")
            } else if let unwrappedData = data {
                do {
                    // Ubah yg didapet jd json kyk di website, tapi pake = instead of : biasa
                    let json = try JSONSerialization.jsonObject(with: unwrappedData, options: [])
                    //                    print(json)
                    if let dictionary = json as? [String:Any] {
                        //                        print(dictionary)
                        var tempUsers: [User] = []
                        let usersJSON = dictionary["data"] as! [[String:Any]]
                        for singleUser in usersJSON{
                            
                            let userId = Int(singleUser["userId"] as! String)
                            let levelId = Int(singleUser["levelId"] as! String)
                            let fullName = singleUser["fullName"] as! String
                            let phone = singleUser["phone"] as! String
                            let email = singleUser["email"] as! String
                            let password = singleUser["password"] as! String
                            
                            let newUser = User(userId: userId!, levelId: levelId!, fullName: fullName, phone: phone, email: email, password: password)
                            
                            tempUsers.append(newUser)
                        }
                        onComplete(tempUsers)
                    }
                } catch {
                    print("Error convert JSON")
                }
            }
        }
        dataTask.resume()
    }
    
    static func getUserByEmail(){
        
    }
    
}
