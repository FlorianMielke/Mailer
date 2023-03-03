/**
 *  Mailer
 *  Copyright (c) Florian Mielke 2021
 *  MIT license, see LICENSE file for details
 */

import SwiftUI
import MessageUI

public struct Mailer: UIViewControllerRepresentable {
  @Environment(\.presentationMode) public var presentationMode
  public let message: Message?
  @Binding public var result: Result<MFMailComposeResult, Error>?
  
  public class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
    let parent: Mailer
    
    init(_ parent: Mailer) {
      self.parent = parent
    }
    
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
      defer {
        parent.presentationMode.wrappedValue.dismiss()
      }
      if let error = error {
        parent.result = .failure(error)
      } else {
        parent.result = .success(result)
      }
    }
  }
  
  public func makeCoordinator() -> Coordinator {
    return Coordinator(self)
  }
  
  public func makeUIViewController(context: Context) -> MFMailComposeViewController {
    let controller = MFMailComposeViewController()
    controller.mailComposeDelegate = context.coordinator
    
    if let message = message {
      controller.setToRecipients(message.toRecipients)
      controller.setCcRecipients(message.ccRecipients)
      controller.setBccRecipients(message.bccRecipients)
      controller.setSubject(message.subject)
      controller.setMessageBody(message.body, isHTML: message.isHTML)
      message.attachments.forEach { attachment in
        controller.addAttachmentData(attachment.dataRepresentation, mimeType: attachment.mimeType, fileName: attachment.fileName)
      }
    }
    
    return controller
  }
  
  public func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {
    
  }
}

extension Mailer {
  public static var canSendMail: Bool {
    MFMailComposeViewController.canSendMail()
  }
  
  public init(error: NSError, result: Binding<Result<MFMailComposeResult, Error>?>) {
    let message = Message(error: error)
    self.init(message: message, result: result)
  }
  
  public static func support() -> Mailer {
    return Mailer(message: Message.support, result: .constant(nil))
  }
}
