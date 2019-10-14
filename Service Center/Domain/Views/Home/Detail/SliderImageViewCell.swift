//
//  SliderImageViewCell.swift
//  Service Center
//
//  Created by Shahid Latif on 2019/10/14.
//  Copyright © 2019 MOHRE. All rights reserved.
//

import Foundation


import UIKit

class SliderImageViewCell:UICollectionViewCell {
    @IBOutlet weak var sliderImageView:UIImageView!
    var viewModel: SliderImageViewModel! {
        didSet {
            viewModel.sliderImageUrl
                .bind(to: sliderImageView.rx.imageURL(withPlaceholder: #imageLiteral(resourceName: "default")))
                .disposed(by: rx.disposeBag)
        }
    }
    
}
