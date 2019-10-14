//
//  ServiceCenterRepository.swift
//  Service Center
//
//  Created by Shahid Latif on 2019/10/14.
//  Copyright © 2019 MOHRE. All rights reserved.
//

import Foundation
import RxSwift

protocol ServiceCenterRepository {
    func getPage(page: Int) -> Observable<ServiceCenters?>
}
