/**
 *  Mailer
 *  Copyright (c) Florian Mielke 2021
 *  MIT license, see LICENSE file for details
 */

import Foundation

extension NSError {
  var shortMessaged: String {
    return [localizedFailureReason, localizedRecoverySuggestion].compactMap { $0 }.joined(separator: "\n\n")
  }
  
  var mediumMessaged: String {
    return [localizedDescription, localizedFailureReason, localizedRecoverySuggestion].compactMap { $0 }.joined(separator: "\n\n")
  }
  
  var longMessaged: String {
    return [localizedDescription, localizedFailureReason, localizedRecoverySuggestion, userInfo.description].compactMap { $0 }.joined(separator: "\n\n")
  }
  
  var completeMessages: String {
    var message = shortMessaged
    if let underlyingError = userInfo[NSUnderlyingErrorKey] as? NSError {
      message += "\n\n\(underlyingError.mediumMessaged)"
    }
    return message
  }
  
  var logFiled: String {
    var message = longMessaged
    if let underlyingError = userInfo[NSUnderlyingErrorKey] as? NSError {
      message += "\n\n\(underlyingError.userInfo)"
    }
    return message
  }
}
