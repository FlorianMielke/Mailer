/**
*  Mailer
*  Copyright (c) Florian Mielke 2021
*  MIT license, see LICENSE file for details
*/

import UIKit

struct Message: Equatable, Hashable {
    var subject = ""
    var body = ""
    var isHTML: Bool = false
    var toRecipients = [String]()
    var ccRecipients = [String]()
    var bccRecipients = [String]()
    var attachments = [Attachment]()
}

// MARK: - Error
extension Message {
    init(error: Error) {
        if let logFile = Attachment(error: error) {
            self.attachments = [logFile]
        }
    }
}

extension Message {
    static var support: Message? {
        let configuration = Mailer.Configuration.shared
        
        guard let supportEmailAddress = configuration.supportEmailAddress else {
            return nil
        }
        
        var message = Message()
        message.toRecipients = [supportEmailAddress]
        message.subject = "\(Bundle.main.appName) \(Bundle.main.presentableVersionNumber)"
        message.body = configuration.appendDeviceInformation ? supportFooter : ""
        return message
    }
    
    private static var supportFooter: String {
        let footer =
            """
            
            -------------------------
            iOS Version: \(UIDevice.current.systemVersion)
            iOS Device: \(UIDevice.current.localizedModel)
            System Language: \(Locale.preferredLanguages.first ?? "Unknown")
            """
        
        return footer
    }
}
