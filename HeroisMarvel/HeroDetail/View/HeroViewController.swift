//
//  HeroViewController.swift
//  HeroisMarvel
//
//  Created by Eric Brito on 22/10/17.
//  Copyright © 2017 Eric Brito. All rights reserved.
//

import UIKit
import WebKit

class HeroViewController: UIViewController {
    
    //MARK: - Outlets and Variables
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    var hero: Hero?
    var viewModel = HeroViewModel()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = hero?.name
        loadHero()
    }
    
        //MARK: - Methods
    func loadHero(){
        viewModel.createRequest(hero: hero) { request in
            self.setWebView(request: request)
        }
    }
    
    func setWebView(request: URLRequest){
        webView.allowsBackForwardNavigationGestures = true
        webView.navigationDelegate = self
        webView.load(request)
    }
}

//MARK: - Extensio WebView
extension HeroViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loading.stopAnimating()
    }
}
