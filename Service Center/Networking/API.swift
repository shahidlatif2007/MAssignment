//
//  API.swift
//  Service Center
//
//  Created by Shahid Latif on 2019/10/13.
//  Copyright © 2019 MOHRE. All rights reserved.
//

import Foundation

import RxSwift
import Alamofire

protocol API {
    static func get(authenticated: Bool, shouldShowAlerts: Bool, endpoint: String, params: [String: Any]?) -> Observable<Any>
    static func post(authenticated: Bool, shouldShowAlerts: Bool, endpoint: String, params: [String: Any]?) -> Observable<Any>
    
    static var isConnectedToInternet: Bool { get }
}

// MARK: - Internet connection check
extension API {
    static var isConnectedToInternet: Bool {
        return NetworkReachabilityManager()?.isReachable ?? true
    }
}

// MARK: - Error handling
enum APIError: Error, LocalizedError {
    case noInternet
    
    var errorDescription: String? {
        switch self {
        case .noInternet:
            return "The Internet connection appears to be offline."
        }
    }
}
