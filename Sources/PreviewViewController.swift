//
//  PreviewViewController
//
import UIKit
import WebKit

open class PreviewViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!

    fileprivate var html: String?
    open var previewPageTitle: String?
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = previewPageTitle

        webView.scrollView.decelerationRate = UIScrollView.DecelerationRate.normal

        if let html = html {
            let replacedHtml = html.replacingOccurrences(of: "\n", with: "<br/>")
            let htmlString = "<html><meta name='viewport' content='width=device-width; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;'></head><body><div style='padding:10px;line-height:1.5em'>\(replacedHtml)</div></body></html>"
            webView.loadHTMLString(htmlString, baseURL: nil)
        }
    }

    open func set(html:String) {
        self.html = html
    }
}
