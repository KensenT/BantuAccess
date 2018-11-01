//
//  Event.swift
//  Bantu
//
//  Created by Resky Javieri on 08/10/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import Foundation
import UIKit

class Event {
    var eventId: Int
    var postId: Int
    var timeStamp: String
    var eventName: String
    var startDate: String
    var endDate: String
    var description: String
    var img: UIImage
    var fee: Double
    var feeInfo: String
    var volunteerNo: Int
    var requirements: String
    var eventNotes: String
    var contactPerson: String
    
    var locationLocality: String
    var locationAdminArea: String
    var locationLatitude: Double
    var locationLongitude: Double
    
    init(eventId: Int, postId: Int, timeStamp: String, eventName: String, startDate: String, endDate: String, description: String, img: UIImage, fee: Double, feeInfo: String, volunteerNo: Int, requirements: String, eventNotes: String, contactPerson: String, locationLocality: String, locationAdminArea: String, locationLatitude: Double, locationLongitude: Double) {
        self.eventId = eventId
        self.postId = postId
        self.timeStamp = timeStamp
        self.eventName = eventName
        self.startDate = startDate
        self.endDate = endDate
        self.description = description
        self.img = img
        self.fee = fee
        self.feeInfo = feeInfo
        self.volunteerNo = volunteerNo
        self.requirements = requirements
        self.eventNotes = eventNotes
        self.contactPerson = contactPerson
        self.locationLocality = locationLocality
        self.locationAdminArea = locationAdminArea
        self.locationLatitude = locationLatitude
        self.locationLongitude = locationLongitude
    }
    
}
