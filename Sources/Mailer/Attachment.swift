/**
 *  Mailer
 *  Copyright (c) Florian Mielke 2021
 *  MIT license, see LICENSE file for details
 */

import Foundation

public struct Attachment: Equatable, Hashable {
  public let dataRepresentation: Data
  public let fileName: String
  public let mimeType: String
}
