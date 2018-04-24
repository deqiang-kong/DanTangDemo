//
//  PostDetailViewController.swift
//  DanTangDemo
//  详情
//

import UIKit

class PostDetailViewController: BaseViewController, UIWebViewDelegate {

    var post: CollectionPost?
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /// 自动对页面进行缩放以适应屏幕
        webView.scalesPageToFit = true
        webView.dataDetectorTypes = .all
        let url = URL(string: post!.content_url!)
        let request = URLRequest(url: url!)
        webView.loadRequest(request)
        view.addSubview(webView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        print(webView.stringByEvaluatingJavaScript(from: "document.documentElement.innerHTML")!)
    }
    
}

