//
//  TVWebView.swift
//  Browser
//
//  Created by nasir on 24/08/2023.
//

import SwiftUI

public struct TVWebView: UIViewRepresentable {
    let vc = TVWebViewController()
    
    public init() {}

    public func makeUIView(context: Context) -> some UIView {
        return vc.view
    }
    
    public func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    public func load(url: URL, _ callback: TVWebViewController.ErrorCallback? = nil) -> TVWebView {
        vc.load(url: url, callback)
        return self
    }
    
    public func enableInteraction(_ enable: Bool) -> TVWebView {
        vc.enableInteraction(enable)
        return self
    }
    
    public func evaluateJavascript(_ js: String) -> String? {
        return vc.evaluateJavascript(js)
    }
}
