//
//  CoreDataManager.swift
//  Service Center
//
//  Created by Shahid Latif on 2019/10/15.
//  Copyright © 2019 MOHRE. All rights reserved.
//

import Foundation
import UIKit

import CoreData

struct CoreDataManager {
    static let shared = CoreDataManager()
    
    var managedObjectContext: NSManagedObjectContext!
    
    init() {
        managedObjectContext = (UIApplication.shared.delegate as? AppDelegate)?.managedObjectContext
    }
}
