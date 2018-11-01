//
//  DraftEntity+CoreDataProperties.swift
//  Bantu
//
//  Created by Gior Fasolini on 16/10/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//
//

import Foundation
import CoreData


extension DraftEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DraftEntity> {
        return NSFetchRequest<DraftEntity>(entityName: "DraftEntity")
    }

    @NSManaged public var aboutPost: String?
    @NSManaged public var accessPost: String?
    @NSManaged public var addressPost: String?
    @NSManaged public var locationAdminArea: String?
    @NSManaged public var locationAOI: String?
    @NSManaged public var locationLatitude: Double
    @NSManaged public var locationLocality: String?
    @NSManaged public var locationLongitude: Double
    @NSManaged public var locationName: String?
    @NSManaged public var needsPost: [[String:Any]]?
    @NSManaged public var notesPost: String?
    @NSManaged public var postUUID: String?
    @NSManaged public var roadImages: NSData?
    @NSManaged public var schoolImages: NSData?
    @NSManaged public var schoolName: String?
    @NSManaged public var studentNo: Int64
    @NSManaged public var teacherNo: Int64
    @NSManaged public var timeStamp: String?

}
