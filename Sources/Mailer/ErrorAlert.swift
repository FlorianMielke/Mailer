/**
 *  Mailer
 *  Copyright (c) Florian Mielke 2021
 *  MIT license, see LICENSE file for details
 */

import SwiftUI

extension Alert {
  public init(error: NSError?, showingMailer: Binding<Bool>, dismissAction: (() -> Void)?) {
    if let error = error {
      if Mailer.canSendMail {
        self.init(title: Text(error.localizedDescription),
                  message: Text(error.completeMessages),
                  primaryButton: .default(Mailer.text("mailer.error-alert.contact-support"), action: { showingMailer.wrappedValue = true }),
                  secondaryButton: .default(Mailer.text("mailer.error-alert.cancel"), action: dismissAction)
        )
      } else {
        self.init(title: Text(error.localizedDescription), message: Text(error.completeMessages), dismissButton: .default(Mailer.text("mailer.error-alert.ok"), action: dismissAction))
      }
    } else {
      if Mailer.canSendMail {
        self.init(title: Mailer.text("mailer.error-alert.unknown-error.title"),
                  message: Mailer.text("mailer.error-alert.unknown-error.text"),
                  primaryButton: .default(Mailer.text("mailer.error-alert.contact-support"), action: { showingMailer.wrappedValue = true }),
                  secondaryButton: .default(Mailer.text("mailer.error-alert.ok"), action: dismissAction)
        )
      } else {
        self.init(title: Mailer.text("mailer.error-alert.unknown-error.title"), message: Mailer.text("mailer.error-alert.unknown-error.text"), dismissButton: .default(Mailer.text("mailer.error-alert.ok"), action: dismissAction))
      }
    }
  }
}

public struct ErrorAlertModifier: ViewModifier {
  @Binding public  var error: NSError?
  public let dismissAction: (() -> Void)?
  public let forceShowing: Bool
  
  @State private var showingAlert: Bool = false
  @State private var showingMailer: Bool = false
  
  public init(error: Binding<NSError?>, forceShowing: Bool, dismissAction: (() -> Void)?) {
    self._error = error
    self.dismissAction = dismissAction
    self.forceShowing = forceShowing
  }
  
  public func body(content: Content) -> some View {
    content
      .alert(isPresented: $showingAlert) {
        Alert(error: error, showingMailer: $showingMailer, dismissAction: dismissAction)
      }
      .sheet(isPresented: $showingMailer, onDismiss: dismissAction) {
        if let error = error {
          Mailer(error: error, result: .constant(nil))
        } else {
          Mailer.support()
        }
      }
      .onChange(of: error) { value in
        showingAlert = value != nil
      }
      .onAppear {
        if error != nil && forceShowing {
          showingAlert = true
        }
      }
  }
}

extension View {
  public func errorAlert(error: Binding<NSError?>, forceShowing: Bool = false, dismissAction: (() -> Void)? = {}) -> some View {
    self.modifier(ErrorAlertModifier(error: error, forceShowing: forceShowing, dismissAction: dismissAction))
  }
}
