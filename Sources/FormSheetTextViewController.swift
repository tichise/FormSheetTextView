//
//  FormSheetTextViewController
//
import UIKit

open class FormSheetTextViewController: UIViewController {
    
    let seguePushPreview = "SeguePushPreview"
    
    var isPreview: Bool = false
    var isInitialPositionHead: Bool = false
    
    var initialText: String?
    var previewPageTitle: String = "Preview"
    var cancelButonText: String = "Cancel"
    var sendButtonText: String = "Send"
    var titleText: String?

    var titleSize: CGFloat?
    var buttonSize: CGFloat?

    @IBOutlet weak var composeTextView: UITextView?
    
    @IBOutlet weak var cancelButton: UIBarButtonItem?
    @IBOutlet weak var sendButton: UIBarButtonItem?
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint?
    
    @objc open var completionHandler: ((_ sendText: String) -> Void)?
    
    
    @objc public static func instantiate() -> FormSheetTextViewController? {
        let storyboardsBundle = getStoryboardsBundle()
        guard let formSheetTextViewController = UIStoryboard(name: "FormSheet", bundle: storyboardsBundle).instantiateInitialViewController() as? FormSheetTextViewController else {
            return nil
        }

        return formSheetTextViewController
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        setUpCancelButton()
        setUpSendButton()

        self.navigationItem.title = titleText
        
        if let titleSize = self.titleSize {
            self.navigationController?.navigationBar.titleTextAttributes
                = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: titleSize)]
        }
    
        if let initialText = self.initialText {
            setUpComposeTextView(initialText: initialText)
        }
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
        // Start keyboard display / hidden notification
        NotificationCenter.default.addObserver(self, selector: #selector(self.UIKeyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillChangeFrame), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        if isInitialPositionHead {
            // Cursor initial position of explanatory area set as head
            composeTextView?.selectedTextRange = composeTextView?.textRange(from: (composeTextView?.beginningOfDocument)!, to: (composeTextView?.beginningOfDocument)!)
        }
        
        composeTextView?.becomeFirstResponder()
    }

    @objc public func set(initialText: String?) {
        self.initialText = initialText
    }
    
    @objc public func set(titleText: String) {
        self.titleText = titleText
    }
    
    @objc public func set(previewPageTitle: String) {
        self.previewPageTitle = previewPageTitle
    }
    
    @objc public func set(cancelButtonText: String) {
        self.cancelButonText = cancelButtonText
    }
    
    @objc public func set(sendButtonText: String) {
        self.sendButtonText = sendButtonText
    }
    
    @objc public func set(titleSize: CGFloat) {
        self.titleSize = titleSize
    }
    
    @objc public func set(buttonSize: CGFloat) {
        self.buttonSize = buttonSize
    }
    
    @objc public func set(isPreview: Bool) {
        self.isPreview = isPreview
    }
    
    @objc public func set(isInitialPositionHead: Bool) {
        self.isInitialPositionHead = isInitialPositionHead
    }

    private func setUpComposeTextView(initialText: String?) {

        guard let composeTextView = composeTextView else {
            return
        }

        let bodyFontDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: UIFont.TextStyle.body)

        let bodyFont = UIFont(descriptor: bodyFontDescriptor, size: 0.0)

        let paragrahStyle = NSMutableParagraphStyle()
        paragrahStyle.lineSpacing = 10.0
        let attributedText = NSMutableAttributedString(string: initialText ?? "")
        attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragrahStyle, range: NSRange(location: 0, length: attributedText.length))
        attributedText.addAttribute(NSAttributedString.Key.font, value: bodyFont, range: NSRange(location: 0, length: attributedText.length))
        composeTextView.attributedText = attributedText

        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 45))
        toolbar.barStyle = .default
        toolbar.backgroundColor = UIColor.white

        if isPreview {
            toolbar.items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), UIBarButtonItem(title: self.previewPageTitle, style: .done, target: self, action: #selector(self.preview))]
        }

        toolbar.sizeToFit()
        composeTextView.inputAccessoryView = toolbar
    }
}
