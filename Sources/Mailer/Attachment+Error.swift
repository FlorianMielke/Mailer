/**
 *  Mailer
 *  Copyright (c) Florian Mielke 2021
 *  MIT license, see LICENSE file for details
 */

import Foundation

extension Attachment {
    public init?(error: Error) {
        guard let data = (error as NSError).logFiled.data(using: .utf8) else {
            return nil
        }
        
        self.dataRepresentation = data
        self.fileName = "\(Bundle.main.appName) \(Date().formattedLogFileDate).log"
        self.mimeType = "text/plain"
    }
}

fileprivate extension Date {
    var formattedLogFileDate: String {
        return Self.dateFormatter.string(from: self)
    }
    
    private static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("yyyy MM dd HH mm")
        return formatter
    }
}
