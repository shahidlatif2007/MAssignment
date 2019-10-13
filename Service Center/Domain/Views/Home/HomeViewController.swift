//
//  HomeViewController.swift
//  Service Center
//
//  Created by Shahid Latif on 2019/10/13.
//  Copyright © 2019 MOHRE. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        MOHREAPI
            .get(authenticated: false, shouldShowAlerts: true, endpoint: "servicecenters", params: ["page": "1"])
            .subscribe(onNext: { (data) in
                print(data)
            }, onError: { (error) in
                print(error)
            })
            .disposed(by: rx.disposeBag)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
