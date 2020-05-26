//
//  AboutAppViewController.swift
//  Tenis
//
//  Created by Edi Stern on 6/27/17.
//  Copyright © 2017 Edi Stern. All rights reserved.
//

import UIKit
import SVProgressHUD

class AboutAppViewController: UIViewController , UIWebViewDelegate {
    @IBOutlet weak var webView : UIWebView!;
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.show();
        webView.delegate = self;
        // se incarca info in webview
        webView.loadRequest(NSURLRequest(url: NSURL(string: "http://semainesportif.com/ro/concept")! as URL) as URLRequest)
    }
    
    
    func onBackButton_Clicked ()
    {
        //Pop view controller to preview view controller
        self.navigationController?.popViewController(animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // se ascunde loading pe finish loading
    func webViewDidFinishLoad(_ webView: UIWebView)
    {
        SVProgressHUD.dismiss();
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
