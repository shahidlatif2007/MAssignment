//
//  GenericResponse.swift
//  Service Center
//
//  Created by Shahid Latif on 2019/10/14.
//  Copyright © 2019 MOHRE. All rights reserved.
//

import Foundation

import ObjectMapper

struct GenericResponse<T: Base>: Base {
    var body: T?
}

extension GenericResponse {
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        body <- map["Body"]
    }
}
