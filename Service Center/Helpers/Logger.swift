//
//  Logger.swift
//  Service Center
//
//  Created by Shahid Latif on 2019/10/13.
//  Copyright © 2019 MOHRE. All rights reserved.
//

import Foundation
import Log

/*
 Refer below for more details
 https://github.com/delba/Log
 */

var AppLogger: Logger = {
    Logger(formatter: .afz, theme: .tomorrowNight)
}()

extension Logger {
    public func enableLogging(_ state: Bool) {
        AppLogger.enabled = state
    }
}

extension Formatters {
    static let afz = Formatter("[%@] %@.%@:%@ \n%@", [
        .date("EEE dd-MMM-yyyy hh:mm:ss.SSS a"),
        .file(fullPath: false, fileExtension: false),
        .function,
        .line,
        .message
        ]
    )
}
