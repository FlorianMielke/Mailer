/**
 *  Mailer
 *  Copyright (c) Florian Mielke 2023
 *  MIT license, see LICENSE file for details
 */

import SwiftUI

public struct ErrorsAlertModifier: ViewModifier {
  @Binding public var isPresenting: Bool
  let errors: [Error]
  public let dismissAction: (() -> Void)?
  
  @State private var showingMailer: Bool = false
  
  public init(isPresenting: Binding<Bool>, errors: [Error], dismissAction: (() -> Void)?) {
    _isPresenting = isPresenting
    self.errors = errors
    self.dismissAction = dismissAction
  }
  
  public func body(content: Content) -> some View {
    let localizedAlertErrors = errors.compactMap { LocalizedAlertError(error: $0) }
    let firstAlertError = localizedAlertErrors.first
    
    content
      .alert(isPresented: $isPresenting, error: firstAlertError) { _ in
        Button {
          showingMailer = true
          isPresenting = false
        } label: {
          Mailer.text("mailer.error-alert.contact-support")
        }

        Button(role: .cancel) {
          isPresenting = false
        } label: {
          Mailer.text("mailer.error-alert.cancel")
        }
      } message: { error in
        Text(error.recoverySuggestion ?? "")
      }
      .sheet(isPresented: $showingMailer, onDismiss: dismissAction) {
        Mailer(errors: errors, result: .constant(nil))
      }
  }
}

extension View {
  public func errorAlert(isPresenting: Binding<Bool>, errors: [Error], dismissAction: (() -> Void)? = {}) -> some View {
    self.modifier(ErrorsAlertModifier(isPresenting: isPresenting, errors: errors, dismissAction: dismissAction))
  }
}

struct LocalizedAlertError: LocalizedError {
    let underlyingError: LocalizedError
    
    var errorDescription: String? {
        underlyingError.errorDescription
    }
    var recoverySuggestion: String? {
        underlyingError.recoverySuggestion
    }
    
    init?(error: Error?) {
        guard let localizedError = error as? LocalizedError else { return nil }
        underlyingError = localizedError
    }
}
