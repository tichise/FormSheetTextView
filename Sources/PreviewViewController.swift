//
//  PreviewViewController
//
import UIKit

public class PreviewViewController: UIViewController {

    @IBOutlet weak var webView:UIWebView?

    private var html:String?
    public var previewPageTitle:String?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = previewPageTitle
                
        webView?.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal
        
        let replacedHtml: String = html!.replacingOccurrences(of: "\n", with: "<br/>")
        let htmlString: String = "<html><meta name='viewport' content='width=device-width; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;'></head><body><div style='padding:10px;line-height:1.5em'>\(replacedHtml)</div></body></html>"
        webView?.loadHTMLString(htmlString, baseURL: nil)
    }

    public func setHtml(html:String) {
        self.html = html
    }
}
