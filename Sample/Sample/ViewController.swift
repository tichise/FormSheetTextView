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
        
        let formSheetTextViewController = FormSheetTextViewController.instantiate()
        formSheetTextViewController.setInitialText((self.baseTextView?.text)!)
        formSheetTextViewController.setTitleText("Title")
        formSheetTextViewController.setCancelButtonText("Cancel")
        formSheetTextViewController.setIsInitialPositionHead(false)
        
        // formSheetTextViewController.setTitleSize(20) // default 15
        // formSheetTextViewController.setButtonSize(20) // default 15

        formSheetTextViewController.setIsPreview(true)
        formSheetTextViewController.setPreviewPageTitle("Preview")
        formSheetTextViewController.setSendButtonText("Send")
        formSheetTextViewController.completionHandler = { sendText in
            
            if (sendText.characters.count > 20) {
                let alertController:UIAlertController = UIAlertController(title:nil, message: "The number of characters exceeds the upper limit. Please enter within 20 characters.", preferredStyle: UIAlertControllerStyle.alert)
                let cancelAction:UIAlertAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.cancel, handler:{ (action:UIAlertAction!) -> Void in
                })
                alertController.addAction(cancelAction)
                formSheetTextViewController.present(alertController, animated: true, completion: nil)
                return
            }
            
            if (sendText.characters.count == 0) {
                let alertController:UIAlertController = UIAlertController(title:nil, message: "It is not input. Please enter.", preferredStyle: UIAlertControllerStyle.alert)
                let cancelAction:UIAlertAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.cancel, handler:{ (action:UIAlertAction!) -> Void in
                })
                alertController.addAction(cancelAction)
                formSheetTextViewController.present(alertController, animated: true, completion: nil)
                return
            }
            
            
            // success
            self.baseTextView?.text = sendText
            
            self.dismiss(animated: true, completion: nil)
        };
        
        let navigationController = UINavigationController(rootViewController: formSheetTextViewController)
        navigationController.modalPresentationStyle = UIModalPresentationStyle.formSheet
        present(navigationController, animated: true, completion: nil)
    }
}

