//
//  CaptionViewController.swift
//  1011LoginDemo
//
//  Created by 黃筱珮 on 2022/11/2.
//

import UIKit
import WebKit

class CaptionViewController: UIViewController {
    
    let webView = WKWebView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)

        guard let url = URL(string: "https://huang0429.github.io/MyProject_HTML/")else{
            return
        }
        webView.load(URLRequest(url: url))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
    

    

}
