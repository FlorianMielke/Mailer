/**
 *  Mailer
 *  Copyright (c) Florian Mielke 2021
 *  MIT license, see LICENSE file for details
 */

import SwiftUI

extension Mailer {
    static func text(_ key: LocalizedStringKey) -> Text {
        Text(key, bundle: .module)
    }
}
