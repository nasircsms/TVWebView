//
//  WebViewController.swift
//  Browser
//
//  Created by nasir on 24/08/2023.
//

import UIKit
import TVWebViewObjc

public class TVWebViewController: UIViewController {
    
    public typealias ErrorCallback = (Error?) -> Void
    
    var webview: TVWebView_Objc?
    var callback: ErrorCallback?
    
    public override func loadView() {
        super.loadView()
        self.view = UIView(frame: UIScreen.main.bounds)
        initWebView()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        webview?.delegate = self
    }
    
    func initWebView() {
        self.webview = TVWebView_Objc(frame: self.view.bounds)
        if let webview = webview {
            print("initWebView - Webview initialized")
            webview.translatesAutoresizingMaskIntoConstraints = false
            webview.clipsToBounds = false
            self.view.addChildView(webview)
        } else {
            print("initWebView - Webview not initialized")
        }
    }
    
    public func load(url: URL, _ callback: ErrorCallback? = nil) {
        self.callback = callback
        if let webview = webview {
            webview.load(url)
        }
        else {
            print("loadURL - Webview not initialized")
        }
    }
    
    public func enableInteraction(_ enable: Bool) {
        if let webview = webview {
            webview.enableInteraction(enable)
        }
        else {
            print("enableInteraction - Webview not initialized")
        }
    }
    
    public func evaluateJavascript(_ js: String) -> String? {
        if let webview = webview {
            return webview.evaluateJavascript(js)
        }
        
        return nil
    }
}

extension TVWebViewController: TVWebView_ObjcDelegate {
    public func didFailWithError(_ error: Error) {
        print("TVWebViewController didFailWithError: \(error)")
        if let callback = callback {
            callback(error)
        }
    }
}

extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
    func removeAllSubviews() {
        for subview in subviews {
            subview.removeFromSuperview()
        }
    }
    
    func addChildView(_ childView:UIView, multiplier:CGFloat = 1.0) {
        childView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(childView)
        childView.frame = self.bounds
        childView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: multiplier).isActive = true
        childView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: multiplier).isActive = true
        childView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        childView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        self.clipsToBounds = true
    }
    
    func addChildView(_ childView:UIView, widthValue:CGFloat = 0, heightValue:CGFloat = 0, centerXValue:CGFloat = 0, centerYValue:CGFloat = 0) {
        childView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(childView)
        childView.frame = self.bounds
        childView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.0, constant: widthValue).isActive = true
        childView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1.0, constant: heightValue).isActive = true
        childView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: centerXValue).isActive = true
        childView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: centerYValue).isActive = true
        
        self.clipsToBounds = true
    }
}
