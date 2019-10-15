//
//  Utils.swift
//  Service Center
//
//  Created by Shahid Latif on 2019/10/13.
//  Copyright © 2019 MOHRE. All rights reserved.
//

import Foundation
import UIKit

import RxSwift

enum Storyboard: String {
    case common = "Common"
    case base = "Base"
    
    case home = "Home"
}

struct Utils {
    static let disposeBag = DisposeBag()
    
    /// Returns application keywindow
    static var applicationKeyWindow: UIWindow? {
        UIApplication.shared.windows.first { $0.isKeyWindow }
    }
    
}

import UIScrollView_InfiniteScroll

extension Reactive where Base: UITableView {
    var infiniteScroll: Observable<Void> {
        return Observable.create { [weak tableView = self.base] observer -> Disposable in
            tableView?.addInfiniteScroll(handler: { _ in
                observer.onNext(())
            })
            
            return Disposables.create()
        }
    }
}

// MARK: - Alerts
extension Utils {
    static func showAlertView(title: String? = nil, message: String?, handler: ((UIAlertAction?) -> Void)?) {
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: handler)
        showAlertView(title: title, message: message, actions: [okAction])
    }
    
    static func showAlertView(title: String? = nil, message: String?, style: UIAlertController.Style = .alert, sourceView: UIView? = nil, actions: [UIAlertAction]) {
        if applicationKeyWindow?.rootViewController?.presentedViewController is UIAlertController { return }
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        
        for action in actions {
            alertController.addAction(action)
        }
        
        alertController.popoverPresentationController?.sourceView = sourceView
        
        if let presentedVC = applicationKeyWindow?.rootViewController?.presentedViewController {
            presentedVC.present(alertController, animated: true, completion: nil)
        } else {
            applicationKeyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
        }
    }
}
