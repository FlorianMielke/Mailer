/**
 *  Mailer
 *  Copyright (c) Florian Mielke 2021
 *  MIT license, see LICENSE file for details
 */

import Foundation

extension Mailer {
    public static func configure(defaultRecipient: String) {
        Configuration.shared.defaultRecipient = defaultRecipient
    }

    public static func configure(appendsDeviceInformation: Bool) {
        Configuration.shared.appendsDeviceInformation = appendsDeviceInformation
    }

    class Configuration {
        static let shared = Configuration()
        
        var defaultRecipient: String? = nil
        var appendsDeviceInformation = true
        
        private init() {
        }
    }
}
