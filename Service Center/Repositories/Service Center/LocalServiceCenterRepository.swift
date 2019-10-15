//
//  LocalServiceCenterRepository.swift
//  Service Center
//
//  Created by Shahid Latif on 2019/10/14.
//  Copyright © 2019 MOHRE. All rights reserved.
//

import Foundation

import RxSwift
import RxCoreData

struct LocalServiceCenterRepository: ServiceCenterRepository {
    func getPage(page: Int) -> Observable<ServiceCenters?> {
        return CoreDataManager.shared.managedObjectContext.rx.entities(ServiceCenter.self, predicate: nil, sortDescriptors: nil)
            .map { ServiceCenters(totalPages: 2, serviceCenters: $0) } 
    }
}
