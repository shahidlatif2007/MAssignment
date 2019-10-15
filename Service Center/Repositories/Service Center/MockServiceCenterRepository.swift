//
//  MockServiceCenterRepository.swift
//  Service Center
//
//  Created by Shahid Latif on 2019/10/14.
//  Copyright © 2019 MOHRE. All rights reserved.
//

import Foundation

import RxSwift

struct MockServiceCenterRepository: ServiceCenterRepository {
    func getPage(page: Int) -> Observable<ServiceCenters?> {
        return Observable.just(
            ServiceCenters(
                totalPages: 4,
                serviceCenters: [
                    ServiceCenter(
                        id: 1,
                        name: "abc",
                        imageURLs: [],
                        workingTime: "asd",
                        contact: "qwe",
                        address: "qwe",
                        rating: 1,
                        thumbImageUrl: URL(string: ""),
                        description: "asd"
                    ),
                    ServiceCenter(
                        id: 2,
                        name: "wqe",
                        imageURLs: [],
                        workingTime: "reg",
                        contact: "dvg",
                        address: "ghh",
                        rating: 2,
                        thumbImageUrl: URL(string: ""),
                        description: "dfh"
                    ),
                    ServiceCenter(
                        id: 3,
                        name: "wqe",
                        imageURLs: [],
                        workingTime: "reg",
                        contact: "dvg",
                        address: "ghh",
                        rating: 2,
                        thumbImageUrl: URL(string: ""),
                        description: "dfh"
                    ),
                    ServiceCenter(
                        id: 4,
                        name: "wqe",
                        imageURLs: [],
                        workingTime: "reg",
                        contact: "dvg",
                        address: "ghh",
                        rating: 2,
                        thumbImageUrl: URL(string: ""),
                        description: "dfh"
                    ),
                    ServiceCenter(
                        id: 5,
                        name: "wqe",
                        imageURLs: [],
                        workingTime: "reg",
                        contact: "dvg",
                        address: "ghh",
                        rating: 2,
                        thumbImageUrl: URL(string: ""),
                        description: "dfh"
                    ),
                    ServiceCenter(
                        id: 6,
                        name: "wqe",
                        imageURLs: [],
                        workingTime: "reg",
                        contact: "dvg",
                        address: "ghh",
                        rating: 2,
                        thumbImageUrl: URL(string: ""),
                        description: "dfh"
                    ),
                    ServiceCenter(
                        id: 7,
                        name: "wqe",
                        imageURLs: [],
                        workingTime: "reg",
                        contact: "dvg",
                        address: "ghh",
                        rating: 2,
                        thumbImageUrl: URL(string: ""),
                        description: "dfh"
                    )
                ]
            )
        )
    }
}
