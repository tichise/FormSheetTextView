//
//  FormSheetTextViewController+Button
//
import UIKit

extension FormSheetTextViewController {

    @objc private func cancel(sender: UIBarButtonItem) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)

        self.dismiss(animated: true, completion:nil)
    }

    @objc private func send(sender: UIBarButtonItem) {
        if let completionHandler = completionHandler, let composeText = composeTextView?.text {
            completionHandler(composeText)
        }
    }

    static func getStoryboardsBundle() -> Bundle? {
        let podBundle = Bundle(for: FormSheetTextViewController.self)
            
    #if SWIFT_PACKAGE
        let bundleURL = podBundle.url(forResource: "FormSheetTextView_FormSheetTextView", withExtension: "bundle")
    #else
        let bundleURL = podBundle.url(forResource: "FormSheetTextViewStoryboards", withExtension: "bundle")
    #endif
        let bundle = Bundle(url: bundleURL!)!
            
        return bundle
    }


    func setUpCancelButton() {
        let leftButton = UIBarButtonItem(title: cancelButonText, style: UIBarButtonItem.Style.plain, target: self, action:#selector(FormSheetTextViewController.cancel(sender:)))

        if let buttonSize = self.buttonSize {
            leftButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: buttonSize)], for: UIControl.State.normal)
        }

        self.navigationItem.leftBarButtonItem = leftButton
    }


    func setUpSendButton() {
        let rightButton = UIBarButtonItem(title: sendButtonText, style: UIBarButtonItem.Style.plain, target: self, action: #selector(FormSheetTextViewController.send(sender:)))

        if let buttonSize = self.buttonSize {
            rightButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: buttonSize)], for: UIControl.State.normal)
        }

        self.navigationItem.rightBarButtonItem = rightButton
    }

    @objc func preview() {
        performSegue(withIdentifier: seguePushPreview, sender: nil)
    }

    override open func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == seguePushPreview {

            guard let previewViewController = segue.destination as? PreviewViewController else {
                return
            }

            previewViewController.previewPageTitle = previewPageTitle

            if let composeText = composeTextView?.text {
                previewViewController.set(html: composeText)
            }
        }
    }
}
