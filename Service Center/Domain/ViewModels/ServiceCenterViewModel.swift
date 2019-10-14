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
    let nameLabel: BehaviorRelay<String?> = BehaviorRelay(value: "--")
    let ratingLabel: BehaviorRelay<Float?> = BehaviorRelay(value: 0)
    let addressLabel: BehaviorRelay<String?> = BehaviorRelay(value: "--")
    let contactNumberLabel: BehaviorRelay<String?> = BehaviorRelay(value: "--")
    
    init(serviceCenter: ServiceCenter) {
        imageUrl.accept(serviceCenter.thumbImageUrl)
        nameLabel.accept(serviceCenter.name)
        ratingLabel.accept(serviceCenter.rating)
        addressLabel.accept(serviceCenter.address)
        contactNumberLabel.accept(serviceCenter.contact)
    }
}
