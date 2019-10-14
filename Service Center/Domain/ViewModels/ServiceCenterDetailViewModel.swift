//
//  ServiceCenterDetailViewModel.swift
//  Service Center
//
//  Created by Shahid Latif on 2019/10/14.
//  Copyright © 2019 MOHRE. All rights reserved.
//



import RxSwift
import RxCocoa

class ServiceCenterDetailViewModel {
    let name: BehaviorRelay<String?> = BehaviorRelay(value: "--")
    let contactNumber: BehaviorRelay<String?> = BehaviorRelay(value: "--")
    let workingTime: BehaviorRelay<String?> = BehaviorRelay(value: "--")
    let descrption: BehaviorRelay<String?> = BehaviorRelay(value: "--")
    let sliderImageUrls: BehaviorRelay<[URL]> = BehaviorRelay(value: [])
    
    init(serviceCenter: ServiceCenter) {
        name.accept(serviceCenter.name)
        contactNumber.accept(serviceCenter.contact)
        workingTime.accept(serviceCenter.workingTime)
        descrption.accept(serviceCenter.description)
        sliderImageUrls.accept(serviceCenter.imageURLs ?? [])
    }
}
