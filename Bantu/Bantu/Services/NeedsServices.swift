//
//  NeedsServices.swift
//  Bantu
//
//  Created by Steven Muliamin on 12/10/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import Foundation

struct NeedsServices {
    static func getNeeds(onComplete: @escaping ([Needs])->()){
        
        let newUrlString = GlobalSession.rootUrl + "/needs/"
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
                        var tempNeeds: [Needs] = []
                        let usersJSON = dictionary["data"] as! [[String:Any]]
                        for singleNeeds in usersJSON{
                            
                            let needsId = Int(singleNeeds["needsId"] as! String)
                            let needsName = singleNeeds["needsName"] as! String
 
                            let newNeeds = Needs(needsId: needsId!, needsName: needsName)
                            
                            tempNeeds.append(newNeeds)
                        }
                        onComplete(tempNeeds)
                    }
                } catch {
                    print("Error convert JSON")
                }
            }
        }
        dataTask.resume()
    }
}
