//
//  HomeViewModel.swift
//  Service Center
//
//  Created by Shahid Latif on 2019/10/14.
//  Copyright © 2019 MOHRE. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa

class HomeViewModel {
    private var page = 1
    
    var serviceCenters: BehaviorRelay<[ServiceCenter]> = BehaviorRelay(value: [])
    
    private let repository: ServiceCenterRepository
    
    let disposeBag = DisposeBag()
    
    init(serviceCenterRepository: ServiceCenterRepository = WebServiceCenterRepository()) {
        repository = serviceCenterRepository
        
        fetchInitialServiceCenters()
            .bind(to: serviceCenters)
            .disposed(by: disposeBag)
    }
    
    func fetchInitialServiceCenters() -> Observable<[ServiceCenter]> {
        page = 1
        
        return repository.getPage(page: page)
            .map { $0?.serviceCenters ?? [] }
    }
    
    func fetchMoreServiceCenters() -> Observable<[ServiceCenter]> {
        page += 1
        
        return repository.getPage(page: page)
            .map { $0?.serviceCenters ?? [] }
    }
}
