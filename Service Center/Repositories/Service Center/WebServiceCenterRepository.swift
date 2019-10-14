//
//  WebServiceCenterRepository.swift
//  Service Center
//
//  Created by Shahid Latif on 2019/10/14.
//  Copyright © 2019 MOHRE. All rights reserved.
//

import Foundation
import RxSwift

struct WebServiceCenterRepository: ServiceCenterRepository {
    func getPage(page: Int) -> Observable<ServiceCenters?> {
        return MOHREAPI.get(authenticated: false, shouldShowAlerts: true, endpoint: "servicecenters", params: ["page": "1"])
            .mapObject(GenericResponse<ServiceCenters>.self)
            .map { $0?.body }
    }
}
