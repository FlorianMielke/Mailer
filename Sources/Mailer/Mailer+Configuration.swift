/**
*  Mailer
*  Copyright (c) Florian Mielke 2021
*  MIT license, see LICENSE file for details
*/

import Foundation

extension Mailer {
    public class Configuration {
        public static let shared = Configuration()
        
        public let supportEmailAddress: String? = nil
        public let appendDeviceInformation = true
        
        private init() {
            
        }
    }
}
