//
//  SliderImageViewModel.swift
//  Service Center
//
//  Created by Shahid Latif on 2019/10/14.
//  Copyright © 2019 MOHRE. All rights reserved.
//

import RxSwift
import RxCocoa

class SliderImageViewModel {
    
    let sliderImageUrl: BehaviorRelay<URL?> = BehaviorRelay(value: nil)
    
    init(sliderURL: URL) {
        sliderImageUrl.accept(sliderURL)
    }
    
    
}
