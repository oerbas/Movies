//
//  WebViewController.swift
//  Movies
//
//  Created by Orhan Erbas on 21.02.2021.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    var imdbID : String!
    
    
    @IBOutlet weak var webView: WKWebView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print(imdbID ?? "")
        let url = URL(string: "\(Constants.imdbBasePath + imdbID)")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        // Do any additional setup after loading the view.
    }
    

    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
