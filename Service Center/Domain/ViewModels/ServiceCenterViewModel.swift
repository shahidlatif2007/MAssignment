//
//  ServiceCenterViewModel.swift
//  Service Center
//
//  Created by Shahid Latif on 2019/10/14.
//  Copyright © 2019 MOHRE. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa

struct ServiceCenterViewModel {
    let imageUrl: BehaviorRelay<URL?> = BehaviorRelay(value: nil)
    let name: BehaviorRelay<String?> = BehaviorRelay(value: "--")
    let rating: BehaviorRelay<Float?> = BehaviorRelay(value: 0)
    let address: BehaviorRelay<String?> = BehaviorRelay(value: "--")
    let contactNumber: BehaviorRelay<String?> = BehaviorRelay(value: "--")
    
    init(serviceCenter: ServiceCenter) {
        imageUrl.accept(serviceCenter.thumbImageUrl)
        name.accept(serviceCenter.name)
        rating.accept(serviceCenter.rating)
        address.accept(serviceCenter.address)
        contactNumber.accept(serviceCenter.contact)
    }
}
