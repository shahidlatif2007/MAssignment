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
    private var totalPages = 0
    private var page = 1
    
    var serviceCenters: BehaviorRelay<[ServiceCenter]> = BehaviorRelay(value: [])
    
    private let repository: ServiceCenterRepository
    
    let disposeBag = DisposeBag()
    
    init(serviceCenterRepository: ServiceCenterRepository = WebServiceCenterRepository()) {
        
        
        repository = serviceCenterRepository
        
        _ = fetchInitialServiceCenters()
    }
    
    func fetchInitialServiceCenters() -> Observable<[ServiceCenter]> {
        page = 1
        
        let serviceCenterSequence = repository.getPage(page: page)
        
        serviceCenterSequence
            .subscribe(onNext: { [weak self] (serviceCenters: ServiceCenters?) in
                self?.totalPages = serviceCenters?.totalPages ?? 0
                self?.setServiceCenters(serviceCenters: serviceCenters?.serviceCenters ?? [])
            })
            .disposed(by: disposeBag)
            
        return serviceCenterSequence
            .map { $0?.serviceCenters ?? [] }
    }
    
    func fetchMoreServiceCenters() -> Observable<[ServiceCenter]> {
        page += 1
        
        guard totalPages >= page else { return Observable.error(ServiceCenterErrors.noMoreRecords) }
        
        let serviceCenterSequence = repository.getPage(page: page)
            .map { $0?.serviceCenters ?? [] }
        
        serviceCenterSequence
            .subscribe(onNext: { [weak self] (moreServiceCenters: [ServiceCenter]) in
                self?.addServiceCenters(serviceCenters: moreServiceCenters)
            })
            .disposed(by: disposeBag)
        
        return serviceCenterSequence
    }
    
    func setServiceCenters(serviceCenters: [ServiceCenter]) {
        // Upserting to core data
        upsertServiceCenterInDatabase(serviceCenters: serviceCenters)
        
        self.serviceCenters.accept(serviceCenters)
    }
    
    func addServiceCenters(serviceCenters: [ServiceCenter]) {
        // Upserting to core data
        upsertServiceCenterInDatabase(serviceCenters: serviceCenters)
        
        var moreServiceCenters = self.serviceCenters.value
        moreServiceCenters.append(contentsOf: serviceCenters)
        self.serviceCenters.accept(moreServiceCenters)
    }
    
    func upsertServiceCenterInDatabase(serviceCenters: [ServiceCenter]) {
        for serviceCenter in serviceCenters {
            try? CoreDataManager.shared.managedObjectContext.rx.update(serviceCenter)
        }
    }
}

enum ServiceCenterErrors: Error, LocalizedError {
    case noMoreRecords
}
