//
//  MOHREAPI.swift
//  
//
//  Created by Shahid Latif on 2019/10/13.
//

import Foundation

import RxSwift
import RxAlamofire
import Alamofire

struct MOHREAPI: API {
    // MARK: - Constants
    private struct Constants {
        static let publicBaseUrl = AppConfigurations.shared.publicUrl!
        static let authenticatedBaseUrl = AppConfigurations.shared.authenticatedUrl!
    }
    
    private static var headers: [String: String] = [:]
}

// MARK: - Communication
extension MOHREAPI {
    static func get(authenticated: Bool = true, shouldShowAlerts: Bool = true, endpoint: String, params: [String: Any]?) -> Observable<Any> {
        return request(method: .get, authenticated: authenticated, shouldShowAlerts: shouldShowAlerts, endpoint: endpoint, params: params)
    }
    
    static func post(authenticated: Bool = true, shouldShowAlerts: Bool = true, endpoint: String, params: [String: Any]?) -> Observable<Any> {
        return request(method: .post, authenticated: authenticated, shouldShowAlerts: shouldShowAlerts, endpoint: endpoint, params: params)
    }
    
    private static func request(method: HTTPMethod, authenticated: Bool = true, shouldShowAlerts: Bool, endpoint: String, params: [String: Any]?) -> Observable<Any> {
        let baseUrl = authenticated ? Constants.authenticatedBaseUrl : Constants.publicBaseUrl
        
        AppLogger.debug(baseUrl + "/services/apexrest/" + endpoint)
        AppLogger.debug(headers)
        AppLogger.debug(params ?? "no params")
        
        var request = RxAlamofire
            .request(
                method,
                baseUrl + "/mob_mol/server/api/info/" + endpoint,
                parameters: params,
                encoding: method == .get ? URLEncoding.default : JSONEncoding.default,
                headers: headers
            )
            .debug()
            .validate(statusCode: 200...500)
            .validate(contentType: ["application/json"])
            .trackActivity(MOHREActivityIndicator.shared.indicator)
            .share(replay: 1)
            .json()
        
        switch AppConfigurations.shared.instance {
        case .development:
            request = request.debug()
        case .staging, .production:
            break
        }
        
        /// Subscribing to handle server errors globally if required
        request
            .mapObject(MOHREResponse.self)
            .subscribe(onError: { (error: Error) in
                handleError(error: error, shouldShowAlerts: shouldShowAlerts)
            })
            .disposed(by: Utils.disposeBag)
        
        return request
    }
    
    private static func handleError(error: Error, shouldShowAlerts: Bool) {
        guard shouldShowAlerts else { return }
        guard let alamofireError = error as? AFError else {
            return Utils.showAlertView(message: error.localizedDescription, handler: nil)
        }
        
        Utils.showAlertView(message: alamofireError.localizedDescription, handler: nil)
    }
}

extension MOHREAPI {
    // MARK: - Error handling
    enum MOHREAPIErrors: Error, LocalizedError {
        case genericError
        
        var errorDescription: String? {
            switch self {
            case .genericError:
                return "An error has occured. Please contact your system administrator."
            }
        }
    }
}

import ObjectMapper

// MARK: - Response from MOHRE API
struct MOHREResponse: Base {
    var entityErrors: [EntityError]?
    
    struct EntityError: Base {
        var description: String?
        
        init?(map: Map) { }
        
        mutating func mapping(map: Map) {
            description <- map["description"]
        }
    }
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        entityErrors <- map["EntityErrors"]
    }
}
