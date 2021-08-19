/**
*  Mailer
*  Copyright (c) Florian Mielke 2021
*  MIT license, see LICENSE file for details
*/

import Foundation

extension Mailer {
    class Configuration {
        static let shared = Configuration()
        
        let supportEmailAddress: String? = nil
        let appendDeviceInformation = true
    }
}
