//
//  Post.swift
//  Bantu
//
//  Created by Steven Muliamin on 11/10/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import Foundation
import UIKit

class Post{
    var postId: Int
    var userId: Int
    var statusId: Int
    var timeStamp: String
    var schoolName: String
    var about: String
    var studentNo: Int
    var teacherNo: Int
    var address: String
    var access: String
    var notes: String
    var locationAOI: String
    var locationName: String
    var locationLocality: String
    var locationAdminArea: String
    var locationLatitude: Double
    var locationLongitude: Double
    var fullName: String
    var statusName: String
    
    var schoolImages: [UIImage]
    var roadImages: [UIImage]
    var needs: [Needs]
    
    init(postId: Int, userId: Int, statusId: Int, timeStamp: String, schoolName: String, about: String, studentNo: Int, teacherNo: Int, address: String, access: String, notes: String, locationAOI: String, locationName: String, locationLocality: String, locationAdminArea: String, locationLatitude: Double, locationLongitude: Double, fullName: String, statusName: String, schoolImages: [UIImage], roadImages: [UIImage], needs: [Needs]) {
        
        self.postId = postId
        self.userId = userId
        self.statusId = statusId
        self.timeStamp = timeStamp
        self.schoolName = schoolName
        self.about = about
        self.studentNo = studentNo
        self.teacherNo = teacherNo
        self.address = address
        self.access = access
        self.notes = notes
        self.locationAOI = locationAOI
        self.locationName = locationName
        self.locationLocality = locationLocality
        self.locationAdminArea = locationAdminArea
        self.locationLatitude = locationLatitude
        self.locationLongitude = locationLongitude
        self.fullName = fullName
        self.statusName = statusName
        
        self.schoolImages = schoolImages
        self.roadImages = roadImages
        self.needs = needs
    }
    
    
}
