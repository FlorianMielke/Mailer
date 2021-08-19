/**
*  Mailer
*  Copyright (c) Florian Mielke 2021
*  MIT license, see LICENSE file for details
*/

import Foundation

extension Bundle {
    public var appName: String {
        return infoDictionary?["CFBundleDisplayName"] as! String
    }
    
    public var versionNumber: String {
        return infoDictionary?["CFBundleShortVersionString"] as! String
    }
    
    public var buildNumber: String {
        return infoDictionary?["CFBundleVersion"] as! String
    }
    
    public var presentableVersionNumber: String {
        return "\(versionNumber) (\(buildNumber))"
    }
}
