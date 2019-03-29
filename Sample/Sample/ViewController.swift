//
//  ViewController.swift
//  Sample
//
//  Created by ichise on 2017/07/19.
//  Copyright © 2017年 ichise. All rights reserved.
//

import UIKit
import FormSheetTextView

class ViewController: UIViewController {
    
    @IBOutlet weak var baseTextView:UITextView?

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    @IBAction func click(sender:UIBarButtonItem) {

        let initialText = self.baseTextView?.text
        
        guard let formSheetTextViewController = FormSheetTextViewController.instantiate() else {
            return
        }

        formSheetTextViewController.set(initialText: initialText)
        formSheetTextViewController.set(titleText: "Title")
        formSheetTextViewController.set(cancelButtonText: "Cancel")
        formSheetTextViewController.set(isInitialPositionHead: false)
        
        // formSheetTextViewController.set(titleSize: 20) // default 15
        // formSheetTextViewController.set(buttonSize: 20) // default 15

        formSheetTextViewController.set(isPreview: true)
        formSheetTextViewController.set(previewPageTitle: "Preview")
        formSheetTextViewController.set(sendButtonText: "Send")
        formSheetTextViewController.completionHandler = { sendText in
            
            if sendText.count > 20 {
                let alertController:UIAlertController = UIAlertController(title:nil, message: "The number of characters exceeds the upper limit. Please enter within 20 characters.", preferredStyle: UIAlertController.Style.alert)
                let cancelAction:UIAlertAction = UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel, handler:{ (action:UIAlertAction!) -> Void in
                })
                alertController.addAction(cancelAction)
                formSheetTextViewController.present(alertController, animated: true, completion: nil)
                return
            }
            
            if sendText.count == 0 {
                let alertController:UIAlertController = UIAlertController(title:nil, message: "It is not input. Please enter.", preferredStyle: UIAlertController.Style.alert)
                let cancelAction:UIAlertAction = UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel, handler:{ (action:UIAlertAction!) -> Void in
                })
                alertController.addAction(cancelAction)
                formSheetTextViewController.present(alertController, animated: true, completion: nil)
                return
            }
            
            
            // success
            self.baseTextView?.text = sendText
            
            formSheetTextViewController.dismiss(animated: true, completion: nil)
        };
        
        let navigationController = UINavigationController(rootViewController: formSheetTextViewController)
        navigationController.modalPresentationStyle = UIModalPresentationStyle.formSheet
        present(navigationController, animated: true, completion: nil)
    }
}

