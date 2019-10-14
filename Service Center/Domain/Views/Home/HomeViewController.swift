//
//  HomeViewController.swift
//  Service Center
//
//  Created by Shahid Latif on 2019/10/13.
//  Copyright © 2019 MOHRE. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let viewModel = HomeViewModel()

    @IBOutlet weak var serviceCentersTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.serviceCenters
            .bind(to: serviceCentersTableView.rx.items) { (tableView, row, serviceCenter) in
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell") as? HomeTableViewCell else { return UITableViewCell() }
                cell.viewModel = ServiceCenterViewModel(serviceCenter: serviceCenter)
                return cell
            }
            .disposed(by: rx.disposeBag)
        
        serviceCentersTableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.performSegue(withIdentifier: "DetailSegue", sender: indexPath)
            }).disposed(by: rx.disposeBag)
        
    }
}

// MARK: Segue related
extension HomeViewController {
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        guard case identifier = "DetailSegue" else { return false }
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailViewController = segue.destination as? DetailViewController else { return }
        guard let indexPath = sender as? IndexPath else { return }
        
        let serviceCenter = viewModel.serviceCenters.value[indexPath.row]
        
        detailViewController.viewModel = ServiceCenterDetailViewModel(serviceCenter: serviceCenter)
    }
}
