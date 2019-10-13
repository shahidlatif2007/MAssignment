//
//  RxObjectMapper.swift
//  Service Center
//
//  Created by Shahid Latif on 2019/10/13.
//  Copyright © 2019 MOHRE. All rights reserved.
//

import ObjectMapper
import RxSwift

enum RxObjectMapperError: Error {
    case parsingError
}

extension ObservableType where Element == Any {
    func mapObject<T>(_ type: T.Type) -> Observable<T?> where T: Mappable {
        let mapper = Mapper<T>()
        
        return self.map { (element) -> T in
            guard let parsedElement = mapper.map(JSONObject: element) else {
                throw RxObjectMapperError.parsingError
            }
            
            return parsedElement
        }
    }
    
    func mapArray<T>(_ type: T.Type) -> Observable<[T]?> where T: Mappable {
        let mapper = Mapper<T>()
        
        return self.map { (element) -> [T] in
            guard let parsedArray = mapper.mapArray(JSONObject: element) else {
                throw RxObjectMapperError.parsingError
            }
            
            return parsedArray
        }
    }
}
