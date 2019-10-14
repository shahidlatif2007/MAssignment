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
    var totalPages: String?
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
    var imageURLs:[String]?
    var workingTime:String?
    var contact:String?
    var address:String?
    var rating:Float?
    var thumbImageUrl:String?
    
}

extension ServiceCenter {
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        id <- map["EntityId"]
        name <- map["Name"]
        rating <- map["Rating"]
        imageURLs <- map["ImageUrls"]
        thumbImageUrl <- map["ThumbImageUrl"]
        workingTime <- map["WorkingTime"]
        contact <- map["Contact.Telephone"]
        address <- map["Contact.Address"]
        
    }
}
