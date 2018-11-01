//
//  PostServices.swift
//  Bantu
//
//  Created by Steven Muliamin on 11/10/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import Foundation
import UIKit

struct PostServices {
    static func getPosts(onComplete: @escaping ([Post]) -> ()){
        let newUrlString = GlobalSession.rootUrl + "/posts/"
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
                        var tempPosts: [Post] = []
                        let postsJSON = dictionary["data"] as! [[String:Any]]
                        for singlePost in postsJSON{
                            
                            let postId = Int(singlePost["postId"] as! String)
                            let userId = Int(singlePost["userId"] as! String)
                            let statusId = Int(singlePost["statusId"] as! String)
                            let timeStamp = singlePost["timeStamp"] as! String
                            let schoolName = singlePost["schoolName"] as! String
                            let about = singlePost["about"] as! String
                            let studentNo = Int(singlePost["studentNo"] as! String)
                            let teacherNo = Int(singlePost["teacherNo"] as! String)
                            let address = singlePost["address"] as! String
                            let access = singlePost["access"] as! String
                            let notes = singlePost["notes"] as! String
                            let locationAOI = singlePost["locationAOI"] as! String
                            let locationName = singlePost["locationName"] as! String
                            let locationLocality = singlePost["locationLocality"] as! String
                            let locationAdminArea = singlePost["locationAdminArea"] as! String
                            let locationLatitude = Double(singlePost["locationLatitude"] as! String)
                            let locationLongitude = Double(singlePost["locationLongitude"] as! String)
                            let fullName = singlePost["fullName"] as! String
                            let statusName = singlePost["statusName"] as! String
                            
                            var tempNeeds: [Needs] = []
                            let needsJSON: [[String:Any]] = singlePost["needs"] as! [[String:Any]]
                            for singleNeeds in needsJSON{
                                let needsId = Int(singleNeeds["needsId"] as! String)
                                let needsName = singleNeeds["needsName"] as! String
                                let newNeeds = Needs(needsId: needsId!, needsName: needsName)
                                tempNeeds.append(newNeeds)
                            }
                            
                            var schoolImages: [UIImage] = []
                            var roadImages: [UIImage] = []
                            
                            let schoolUrls: [String] = singlePost["schoolImages"] as! [String]
                            print("schoolUrl : \(schoolUrls)")
                            let roadUrls: [String] = singlePost["roadImages"] as! [String]
                            
                            for singleSchoolUrl in schoolUrls{
                                print("loading schoolImg")
                                let url = URL(string: singleSchoolUrl)
                                let data = try? Data(contentsOf: url!)
                                if let imageData = data {
                                    let image = UIImage(data: imageData)
                                    schoolImages.append(image!)
                                    print("done loading school")
                                }
                            }
                            
                            for singleRoadUrl in roadUrls{
                                print("loading roadImg")
                                let url = URL(string: singleRoadUrl)
                                let data = try? Data(contentsOf: url!)
                                
                                if let imageData = data {
                                    let image = UIImage(data: imageData)
                                    roadImages.append(image!)
                                    print("done loading road")
                                }
                            }
                            
                            let newPost = Post(postId: postId!, userId: userId!, statusId: statusId!, timeStamp: timeStamp, schoolName: schoolName, about: about, studentNo: studentNo!, teacherNo: teacherNo!, address: address, access: access, notes: notes, locationAOI: locationAOI, locationName: locationName, locationLocality: locationLocality, locationAdminArea: locationAdminArea, locationLatitude: locationLatitude!, locationLongitude: locationLongitude!, fullName: fullName, statusName: statusName, schoolImages: schoolImages, roadImages: roadImages, needs: tempNeeds)
                            
                            tempPosts.append(newPost)
                        }
                        onComplete(tempPosts)
                    }
                } catch {
                    print("Error convert JSON")
                }
            }
        }
        dataTask.resume()
    }
    
    static func getPostsByUser(onComplete: @escaping ([Post]) -> ()){
        let newUrlString = GlobalSession.rootUrl + "/posts/user/\(GlobalSession.loggedInUser.userId)"
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
                        var tempPosts: [Post] = []
                        let postsJSON = dictionary["data"] as! [[String:Any]]
                        for singlePost in postsJSON{
                            
                            let postId = Int(singlePost["postId"] as! String)
                            let userId = Int(singlePost["userId"] as! String)
                            let statusId = Int(singlePost["statusId"] as! String)
                            let timeStamp = singlePost["timeStamp"] as! String
                            let schoolName = singlePost["schoolName"] as! String
                            let about = singlePost["about"] as! String
                            let studentNo = Int(singlePost["studentNo"] as! String)
                            let teacherNo = Int(singlePost["teacherNo"] as! String)
                            let address = singlePost["address"] as! String
                            let access = singlePost["access"] as! String
                            let notes = singlePost["notes"] as! String
                            let locationAOI = singlePost["locationAOI"] as! String
                            let locationName = singlePost["locationName"] as! String
                            let locationLocality = singlePost["locationLocality"] as! String
                            let locationAdminArea = singlePost["locationAdminArea"] as! String
                            let locationLatitude = Double(singlePost["locationLatitude"] as! String)
                            let locationLongitude = Double(singlePost["locationLongitude"] as! String)
                            let fullName = singlePost["schoolName"] as! String
                            let statusName = singlePost["statusName"] as! String
                            
                            var tempNeeds: [Needs] = []
                            let needsJSON: [[String:Any]] = singlePost["needs"] as! [[String:Any]]
                            for singleNeeds in needsJSON{
                                let needsId = Int(singleNeeds["needsId"] as! String)
                                let needsName = singleNeeds["needsName"] as! String
                                let newNeeds = Needs(needsId: needsId!, needsName: needsName)
                                tempNeeds.append(newNeeds)
                            }
                            
                            var schoolImages: [UIImage] = []
                            var roadImages: [UIImage] = []
                            
                            let schoolUrls: [String] = singlePost["schoolImages"] as! [String]
                            print("schoolUrl : \(schoolUrls)")
                            let roadUrls: [String] = singlePost["roadImages"] as! [String]
                            
                            for singleSchoolUrl in schoolUrls{
                                print("loading schoolImg")
                                let url = URL(string: singleSchoolUrl)
                                let data = try? Data(contentsOf: url!)
                                if let imageData = data {
                                    let image = UIImage(data: imageData)
                                    schoolImages.append(image!)
                                    print("done loading school")
                                }
                            }
                            
                            for singleRoadUrl in roadUrls{
                                print("loading roadImg")
                                let url = URL(string: singleRoadUrl)
                                let data = try? Data(contentsOf: url!)
                                
                                if let imageData = data {
                                    let image = UIImage(data: imageData)
                                    roadImages.append(image!)
                                    print("done loading road")
                                }
                            }
                            
                            let newPost = Post(postId: postId!, userId: userId!, statusId: statusId!, timeStamp: timeStamp, schoolName: schoolName, about: about, studentNo: studentNo!, teacherNo: teacherNo!, address: address, access: access, notes: notes, locationAOI: locationAOI, locationName: locationName, locationLocality: locationLocality, locationAdminArea: locationAdminArea, locationLatitude: locationLatitude!, locationLongitude: locationLongitude!, fullName: fullName, statusName: statusName, schoolImages: schoolImages, roadImages: roadImages, needs: tempNeeds)
                            
                            tempPosts.append(newPost)
                        }
                        onComplete(tempPosts)
                    }
                } catch {
                    print("Error convert JSON")
                }
            }
        }
        dataTask.resume()
    }
    
    static func updatePostStatus(postId: Int, statusId: Int, onComplete: @escaping () -> ()){
        let newUrlString = GlobalSession.rootUrl + "/postsStatus/\(postId)"
        let url = URL(string: newUrlString)
        
        var urlRequest = URLRequest.init(url: url!)
        urlRequest.httpMethod = "PUT"
        
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonInput = ["statusId":statusId]
        let data = try? JSONSerialization.data(withJSONObject: jsonInput, options: [])
        
        urlRequest.httpBody = data
        let dataTask = GlobalSession.session.dataTask(with: urlRequest) { (data, response, error) in
            if let unwrappedError = error {
                print("Error = \(unwrappedError.localizedDescription)")
            } else if let unwrappedData = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: unwrappedData, options: [])
                    if let dictionary = json as? [String:Any] {
                        print(dictionary)
                        print("Update successful")
                    }
                } catch {
                }
            }
        }
        dataTask.resume()
    }
}
