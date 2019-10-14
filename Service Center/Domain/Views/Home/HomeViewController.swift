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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        viewModel.fetchInitialServiceCenters()
            .subscribe(onNext: { (serviceCenters: [ServiceCenter]) in
                print(serviceCenters)
            }, onError: { (error: Error) in
                print(error)
            })
            .disposed(by: rx.disposeBag)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource  {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let homeCellIdentifier = "homeCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: homeCellIdentifier, for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "detailScreen", sender: nil)
    }
}


