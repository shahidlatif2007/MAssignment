//
//  MOHREActivityIndicator.swift
//  Service Center
//
//  Created by Shahid Latif on 2019/10/13.
//  Copyright © 2019 MOHRE. All rights reserved.
//

import RxSwift
import RxCocoa
import NVActivityIndicatorView
import NSObject_Rx

/// Wrapper for indicator view
class MOHREActivityIndicator: ReactiveCompatible {
    static let shared = MOHREActivityIndicator()
    
    let indicator = ActivityIndicator()
    
    fileprivate var showIndicator = true
    fileprivate let nvIndicator = NVActivityIndicatorPresenter.sharedInstance
    fileprivate let activityData = ActivityData(size: CGSize(width: 70, height: 70),
                                                type: .ballScaleRipple)
    
    private init() {
        // Subscribing to application's activity indicator
        indicator
            .drive(UIApplication.shared.rx.isNetworkActivityIndicatorVisible)
            .disposed(by: rx.disposeBag)
        
        // Subscribing to overlay activity indicator
        indicator
            .drive(rx.animating)
            .disposed(by: rx.disposeBag)
    }
    
    func hideIndicator() {
        showIndicator = false
    }
}

extension Reactive where Base: MOHREActivityIndicator {
    /// Bindable sink for `animating` property.
    var animating: Binder<Bool> {
        return Binder(self.base) { indicator, animating in
            if animating && indicator.showIndicator {
                indicator.nvIndicator.startAnimating(indicator.activityData, nil)
            } else {
                indicator.nvIndicator.stopAnimating(nil)
                
                /// Switching back hideIndicator on
                indicator.showIndicator = true
            }
        }
    }
}
