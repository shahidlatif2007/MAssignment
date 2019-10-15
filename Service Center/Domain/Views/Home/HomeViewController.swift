//
//  HomeViewController.swift
//  Service Center
//
//  Created by Shahid Latif on 2019/10/13.
//  Copyright © 2019 MOHRE. All rights reserved.
//

import UIKit
import RxSwift
import CoreData

class HomeViewController: UIViewController {
    
    private let viewModel = HomeViewModel()
    let refereshControl = UIRefreshControl()

    @IBOutlet weak var serviceCentersTableView: UITableView!
    
//    Will used for showing offline data showing when no connectivity.
//    This fetcher will point to ServiceCenter entity and will add/update any record in the UI.
//    let NSFetchedResultsController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        serviceCentersTableView.refreshControl = refereshControl
        
        serviceCentersTableView.refreshControl?.rx.controlEvent(.valueChanged)
            .flatMap { _ -> Observable<Event<[ServiceCenter]>> in
                MOHREActivityIndicator.shared.hideIndicator()
                return self.viewModel.fetchInitialServiceCenters().materialize()
            }
            .subscribe(onNext: { [weak self] (event: Event<[ServiceCenter]>) in
                self?.serviceCentersTableView.refreshControl?.endRefreshing()
            })
            .disposed(by: rx.disposeBag)

        viewModel.serviceCenters
            .map { [weak self] serviceCenters -> [ServiceCenter] in
                self?.serviceCentersTableView?.finishInfiniteScroll()
                return serviceCenters
            }
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
        
        serviceCentersTableView.rx.infiniteScroll
            .flatMap { _ -> Observable<Event<[ServiceCenter]>> in
                MOHREActivityIndicator.shared.hideIndicator()
                return self.viewModel.fetchMoreServiceCenters().materialize()
            }
            .subscribe(onNext: { [weak self] (event: Event<[ServiceCenter]>) in
                self?.serviceCentersTableView?.finishInfiniteScroll()
                
                guard let error = event.error, case ServiceCenterErrors.noMoreRecords = error else { return }
                Utils.showAlertView(message: "No more records found", handler: nil)
            })
            .disposed(by: rx.disposeBag)
        
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
