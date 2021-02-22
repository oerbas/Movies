//
//  WebViewController.swift
//  Movies
//
//  Created by Orhan Erbas on 21.02.2021.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    var imdbID : String!

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "\(Constants.imdbBasePath + imdbID)")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }

    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
