/**
 *  Mailer
 *  Copyright (c) Florian Mielke 2021
 *  MIT license, see LICENSE file for details
 */

import Foundation

extension Mailer {
    public static func configure(defaultRecipients: [String]) {
        Configuration.shared.defaultRecipients = defaultRecipients
    }

    public static func configure(appendsDeviceInformation: Bool) {
        Configuration.shared.appendsDeviceInformation = appendsDeviceInformation
    }

    class Configuration {
        static let shared = Configuration()
        
        var defaultRecipients = [String]()
        var appendsDeviceInformation = false
        
        private init() {
        }
    }
}
