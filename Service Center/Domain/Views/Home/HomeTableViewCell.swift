//
//  HomeTableViewCell.swift
//  Service Center
//
//  Created by Shahid Latif on 2019/10/14.
//  Copyright © 2019 MOHRE. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var contactNumberLabel: UILabel!
    
    var viewModel: ServiceCenterViewModel! {
        didSet {
            
            viewModel.imageUrl
                .bind(to: thumbnailImageView.rx.imageURL(withPlaceholder: #imageLiteral(resourceName: "default")))
                .disposed(by: rx.disposeBag)
            
            viewModel.name
                .bind(to: nameLabel.rx.text)
                .disposed(by: rx.disposeBag)
            
            viewModel.rating
                .map { "\($0 ?? 0)"}
                .bind(to: ratingLabel.rx.text)
                .disposed(by: rx.disposeBag)
            
            viewModel.address
                .bind(to: addressLabel.rx.text)
                .disposed(by: rx.disposeBag)
            
            viewModel.contactNumber
                .bind(to: contactNumberLabel.rx.text)
                .disposed(by: rx.disposeBag)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
