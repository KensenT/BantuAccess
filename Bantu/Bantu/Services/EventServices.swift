//
//  EventServices.swift
//  Bantu
//
//  Created by Steven Muliamin on 16/10/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import Foundation
import UIKit

struct EventServices {
    static func getEvents(onComplete: @escaping ([Event]) -> ()){
        let newUrlString = GlobalSession.rootUrl + "/events/"
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
                        var tempEvents: [Event] = []
                        let eventsJSON = dictionary["data"] as! [[String:Any]]
                        for singleEvent in eventsJSON{
                            
                            let eventId = Int(singleEvent["eventId"] as! String)
                            let postId = Int(singleEvent["postId"] as! String)
                            let timeStamp = singleEvent["timeStamp"] as! String
                            let eventName = singleEvent["eventName"] as! String
                            let startDate = singleEvent["startDate"] as! String
                            let endDate = singleEvent["endDate"] as! String
                            let description = singleEvent["description"] as! String
                            let fee = Double(singleEvent["fee"] as! String)
                            let feeInfo = singleEvent["feeInfo"] as! String
                            let volunteerNo = Int(singleEvent["volunteerNo"] as! String)
                            let requirements = singleEvent["requirements"] as! String
                            let eventNotes = singleEvent["eventNotes"] as! String
                            let contactPerson = singleEvent["contactPerson"] as! String
                            let locationLocality = singleEvent["locationLocality"] as! String
                            let locationAdminArea = singleEvent["locationAdminArea"] as! String
                            let locationLatitude = Double(singleEvent["locationLatitude"] as! String)
                            let locationLongitude = Double(singleEvent["locationLongitude"] as! String)
                            
                            let imgUrl = singleEvent["imgUrl"] as! String
                            var loadedImage: UIImage!
                            let url = URL(string: imgUrl)
                            let data = try? Data(contentsOf: url!)
                            if let imageData = data {
                                let image = UIImage(data: imageData)
                                loadedImage = image
                            }
                            
                            let newEvent = Event(eventId: eventId!, postId: postId!, timeStamp: timeStamp, eventName: eventName, startDate: startDate, endDate: endDate, description: description, img: loadedImage, fee: fee!, feeInfo: feeInfo, volunteerNo: volunteerNo!, requirements: requirements, eventNotes: eventNotes, contactPerson: contactPerson, locationLocality: locationLocality, locationAdminArea: locationAdminArea, locationLatitude: locationLatitude!, locationLongitude: locationLongitude!)
                            
                            tempEvents.append(newEvent)
                        }
                        onComplete(tempEvents)
                    }
                } catch {
                    print("Error convert JSON")
                }
            }
        }
        dataTask.resume()
    }
}
