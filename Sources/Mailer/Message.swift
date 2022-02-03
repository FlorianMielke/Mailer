/**
 *  Mailer
 *  Copyright (c) Florian Mielke 2021
 *  MIT license, see LICENSE file for details
 */

import UIKit

public struct Message: Equatable, Hashable {
    public var subject = ""
    public var body = ""
    public var isHTML: Bool = false
    public var toRecipients: [String]
    public var ccRecipients = [String]()
    public var bccRecipients = [String]()
    public var attachments = [Attachment]()
}

// MARK: - Error
extension Message {
    public init() {
        if let supportEmailAddress = Mailer.Configuration.shared.defaultRecipient {
            toRecipients = [supportEmailAddress]
        } else {
            toRecipients = [String]()
        }
        
        body = Mailer.Configuration.shared.appendsDeviceInformation ? Message.deviceInformation : ""
    }
    
    public init(error: Error) {
        self.init()
        if let logFile = Attachment(error: error) {
            attachments = [logFile]
        }
    }

    public static var support: Message {
        var message = Message()
        message.subject = "\(Bundle.main.appName) \(Bundle.main.presentableVersionNumber)"
        return message
    }
    
    private static var deviceInformation: String {
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
