//
//  AppConfiguration.swift
//  Service Center
//
//  Created by Shahid Latif on 2019/10/13.
//  Copyright © 2019 MOHRE. All rights reserved.
//

import Foundation

import SDWebImage
import ObjectMapper

struct AppConfigurations {
    enum Instance: String {
        case development = "DEV"
        case staging = "STAG"
        case production = "PROD"
        
        static var `default`: Instance {
            return .development
        }
    }
    
    static let shared = AppConfigurations()
    
    let authenticatedUrl: String?
    let publicUrl: String?
    let instance: Instance
    
    init() {
        guard let configurations = Bundle.main.infoDictionary?[.configurations] as? [String: Any] else {
            authenticatedUrl = nil
            publicUrl = nil
            instance = .default
            
            return
        }
        
        authenticatedUrl = configurations[.authenticatedUrl] as? String
        publicUrl = configurations[.publicUrl] as? String
        instance = Instance(rawValue: configurations[.instance] as? String ?? "") ?? .default
        
        if let logEnabled = configurations[.logEnabled] as? String {
            let logging = Bool(logEnabled) ?? false
            AppLogger.enableLogging(logging)
        }
        
        initializeConfigurations()
    }
    
    private func initializeConfigurations() {
        switch instance {
        case .development:
            /// Clearing image cache
            SDWebImageManager.shared.imageCache.clear(with: .disk, completion: nil)
        case .staging, .production:
            break
        }
        
        /// Image cache configurations
//        SDWebImageManager.shared().imageCache?.config.maxCacheAge = 60 * 60 * 24 * 7 * 2 // (2 weeks)
    }
}

// MARK: - Keys
extension String {
    static let configurations = "Configurations"
    static let authenticatedUrl = "Authenticated URL"
    static let publicUrl = "Public URL"
    static let instance = "Instance"
    static let logEnabled = "Log Enabled"
}
