//
//  ServiceCenter.swift
//  Service Center
//
//  Created by Shahid Latif on 2019/10/14.
//  Copyright © 2019 MOHRE. All rights reserved.
//

import Foundation

import ObjectMapper

struct ServiceCenters: Base {
    var totalPages: Int?
    var serviceCenters: [ServiceCenter]?
}

extension ServiceCenters {
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        totalPages <- map["MetaData.TotalPages"]
        serviceCenters <- map["Items"]
    }
}

struct ServiceCenter: Base {
    var id: Int?
    var name: String?
    var imageURLs: [URL]?
    var workingTime: String?
    var contact: String?
    var address: String?
    var rating: Float?
    var thumbImageUrl: URL?
    var description: String?
}

extension ServiceCenter {
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        id <- map["EntityId"]
        name <- map["Name"]
        rating <- map["Rating"]
        imageURLs <- (map["ImageUrls"], URLTransform())
        thumbImageUrl <- (map["ThumbImageUrl"], URLTransform())
        workingTime <- map["WorkingTime"]
        contact <- map["Contact.Telephone"]
        address <- map["Contact.Address"]
        description <- map["Description"]
    }
}

import CoreData
import RxCoreData

// MARK: Core Date related
func == (lhs: ServiceCenter, rhs: ServiceCenter) -> Bool {
    return lhs.id == rhs.id
}

extension ServiceCenter : Equatable { }

extension ServiceCenter: Persistable {
    var identity: String {
        return "\(id ?? 0)"
    }
    
    typealias T = NSManagedObject
    
    static var entityName: String {
        return "MOHREServiceCenter"
    }
    
    static var primaryAttributeName: String {
        return "id"
    }
    
    init(entity: T) {
        id = entity.value(forKey: "id") as? Int
        rating = entity.value(forKey: "rating") as? Float
        name = entity.value(forKey: "name") as? String
        address = entity.value(forKey: "address") as? String
        workingTime = entity.value(forKey: "workingTime") as? String
        contact = entity.value(forKey: "contact") as? String
    }
    
    func update(_ entity: T) {
        entity.setValue(id, forKey: "id")
        entity.setValue(rating, forKey: "rating")
        entity.setValue(name, forKey: "name")
        entity.setValue(address, forKey: "address")
        entity.setValue(workingTime, forKey: "workingTime")
        entity.setValue(contact, forKey: "contact")
        
        do {
            try entity.managedObjectContext?.save()
        } catch let e {
            print(e)
        }
    }
}

