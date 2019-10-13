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
    
    /// Returns application delegate
    static var applicationDelegate: AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
    
    /// Returns application keywindow
    static var applicationKeyWindow: UIWindow? {
        return UIApplication.shared.keyWindow
    }
    
    /// Returns Storyboard
    ///
    /// - Parameter type: Storyboard
    /// - Returns: UIStoryboard
    static func getStoryboard(type: Storyboard) -> UIStoryboard {
        return UIStoryboard(name: type.rawValue, bundle: nil)
    }
    
    /// Switches to view controller specified
    ///
    /// - Parameters:
    ///   - viewController: View Controller to switch
    ///   - animationOption: Switching animaion type
    ///   - duration: Duration of switching animation
    static func switchToViewController(viewController: UIViewController,
                                       animationOption: UIView.AnimationOptions = .transitionCrossDissolve,
                                       duration: TimeInterval = 0.5,
                                       completion: (() -> Void)? = nil) {
        guard let applicationKeyWindow = applicationKeyWindow else { return }
        
        applicationKeyWindow.rootViewController = viewController
        
        UIView.transition(
            with: applicationKeyWindow,
            duration: duration,
            options: animationOption,
            animations: nil,
            completion: { (_ finished: Bool) in
                completion?()
        })
    }
}

// MARK: - Alerts
extension Utils {
    /// Shows alert view
    ///
    /// - Parameters:
    ///   - title: Title for alert
    ///   - message: Message for alert
    ///   - handler: Code to execute on tapping OK
    static func showAlertView(title: String? = nil, message: String?, handler: ((UIAlertAction?) -> Void)?) {
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: handler)
        showAlertView(title: title, message: message, actions: [okAction])
    }
    
    /// Shows alert view
    ///
    /// - Parameters:
    ///   - title: Title for alert
    ///   - message: Message for alert
    ///   - completionHandler: Code to execute on tapping yes
    
    static func showAlertView(title: String? = nil, message: String?, noTitle: String = "No", yesTitle: String = "Yes", yesHandler: ((UIAlertAction?) -> Void)?) {
        let noAction = UIAlertAction(title: noTitle, style: .cancel, handler: nil)
        let yesAction = UIAlertAction(title: yesTitle, style: .default, handler: yesHandler)
        
        showAlertView(title: title, message: message, actions: [noAction, yesAction])
    }
    
    /// Shows alert view
    ///
    /// - Parameters:
    ///   - title: Title for alert
    ///   - message: Message for alert
    ///   - actions: Actions for alert, e.g., ok, cancel.. buttons
    static func showAlertView(title: String? = nil, message: String?, style: UIAlertController.Style = .alert, sourceView: UIView? = nil, actions: [UIAlertAction]) {
        if applicationKeyWindow?.rootViewController?.presentedViewController is UIAlertController { return }
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
//        alertController.view.tintColor = UIColor.appBlue
        
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
