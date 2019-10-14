//
//  DetailViewController.swift
//  Service Center
//
//  Created by Shahid Latif on 2019/10/14.
//  Copyright © 2019 MOHRE. All rights reserved.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {

    @IBOutlet weak var sliderCollectionView:UICollectionView!
    @IBOutlet weak var pageControl:UIPageControl!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contactLabel:UILabel!
    @IBOutlet weak var workingTimeLabel:UILabel!
    @IBOutlet weak var descriptionTextView:UITextView!
    
    var viewModel: ServiceCenterDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pageControl.numberOfPages = 4
        
        viewModel.name
            .bind(to: nameLabel.rx.text)
            .disposed(by: rx.disposeBag)
        
        viewModel.contactNumber
            .bind(to: contactLabel.rx.text)
            .disposed(by: rx.disposeBag)
        
        viewModel.workingTime
            .bind(to: workingTimeLabel.rx.text)
            .disposed(by: rx.disposeBag)
        
        viewModel.descrption
            .bind(to: descriptionTextView.rx.text)
            .disposed(by: rx.disposeBag)
        
        sliderCollectionView.rx
            .setDelegate(self)
            .disposed(by: rx.disposeBag)
        
        viewModel.sliderImageUrls
            .bind(to: sliderCollectionView.rx.items(
                cellIdentifier: "SliderCell",
                cellType: SliderImageViewCell.self)) { (_, imageURL, cell) in
                    cell.viewModel = SliderImageViewModel(sliderURL: imageURL)
            }
            .disposed(by: rx.disposeBag)
    }
}

extension DetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
}

extension DetailViewController {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
}
