/**
*  Mailer
*  Copyright (c) Florian Mielke 2021
*  MIT license, see LICENSE file for details
*/

import Foundation

struct Attachment: Equatable, Hashable {
    let dataRepresentation: Data
    let fileName: String
    let mimeType: String
}
