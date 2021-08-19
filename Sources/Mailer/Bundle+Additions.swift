/**
*  Mailer
*  Copyright (c) Florian Mielke 2021
*  MIT license, see LICENSE file for details
*/

import Foundation

extension Bundle {
    var appName: String {
        return infoDictionary?["CFBundleDisplayName"] as! String
    }
    
    var versionNumber: String {
        return infoDictionary?["CFBundleShortVersionString"] as! String
    }
    
    var buildNumber: String {
        return infoDictionary?["CFBundleVersion"] as! String
    }
    
    var presentableVersionNumber: String {
        return "\(versionNumber) (\(buildNumber))"
    }
}
