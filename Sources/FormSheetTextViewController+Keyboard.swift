//
//  FormSheetTextViewController+Keyboard
//
import UIKit

extension FormSheetTextViewController {

    @objc func UIKeyboardWillShow(notification: NSNotification) {
        keyboardWillChangeFrame(notification: notification)
    }

    @objc func keyboardWillChangeFrame(notification: NSNotification) {
        let info = notification.userInfo

        let windowHeight = UIScreen.main.bounds.size.height

        // キーボードの大きさを取得
        let keyboardRect = (info?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardHeight = keyboardRect.size.height

        // Form Sheet(UIModalPresentationFormSheet) 高さ
        guard let superview = self.view.superview else {
            return
        }

        let formSheetHeight = superview.frame.size.height

        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad {
            // iPadの場合
            if UIDevice.current.orientation.isLandscape {
                let statusBarHeight = UIApplication.shared.statusBarFrame.size.height

                // キーボードの高さ - form sheetの下の余白の高さ
                bottomConstraint?.constant = keyboardHeight - ((windowHeight - formSheetHeight - statusBarHeight)) + 10
            } else {
                bottomConstraint?.constant = keyboardHeight - ((windowHeight - formSheetHeight) / 2) + 10
            }
        } else {
            bottomConstraint?.constant = keyboardHeight + 10
        }

        let duration = CDouble(info?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval ?? TimeInterval())
        UIView.animate(withDuration: duration, animations: {() -> Void in
            self.view.layoutIfNeeded()
        })
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        bottomConstraint?.constant = 10

        let info: [AnyHashable: Any]? = notification.userInfo

        let duration = CDouble(info?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval ?? TimeInterval())

        UIView.animate(withDuration: duration, animations: {() -> Void in
            self.view.layoutIfNeeded()
        })
    }
}
