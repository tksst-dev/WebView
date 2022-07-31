//
//  WKWebKit.swift
//  WebView
//
//  Created by 習田武志 on 2022/07/30.
//

//import UIKit
//import WebKit
//
//class ViewController: UIViewController, WKUIDelegate {
//
//    var webView: WKWebView!
//
//    override func loadView() {
//        let webConfiguration = WKWebViewConfiguration()
//        webView = WKWebView(frame: .zero, configuration: webConfiguration)
//        webView.uiDelegate = self
//        view = webView
//    }
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        let myURL = URL(string:"https://www.apple.com")
//        let myRequest = URLRequest(url: myURL!)
//        webView.load(myRequest)
//    }
//}
import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    var webView = WKWebView()
    var urlString: String
    
    class Coordinator: NSObject, WKUIDelegate, WKNavigationDelegate {
        var parent: WebView
        
        init(_ parent: WebView) {
            self.parent = parent
        }
        
        // "target="_blank""が設定されたリンクも開けるようにする
        func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
            if navigationAction.targetFrame == nil {
                webView.load(navigationAction.request)
            }
            return nil
        }
        
        // URLごとに処理を制御する
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void) {
            if let url = navigationAction.request.url?.absoluteString {
                if (url.hasPrefix("https://apps.apple.com/")) {
                    guard let appStoreLink = URL(string: url) else {
                        return
                    }
                    UIApplication.shared.open(appStoreLink, options: [:], completionHandler: { (succes) in
                    })
                    decisionHandler(WKNavigationActionPolicy.cancel)
                } else if (url.hasPrefix("http")) {
                    decisionHandler(WKNavigationActionPolicy.allow)
                } else {
                    decisionHandler(WKNavigationActionPolicy.cancel)
                }
            }
        }
        
        // 表示しているページ情報
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            // 表示しているページのURL
            print(webView.url?.absoluteString ?? "")
            // 表示しているページのタイトル
            print(webView.title ?? "")
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        // makeCoordinatorで生成したCoordinatorクラスのインスタンスを指定
        webView.uiDelegate = context.coordinator
        webView.navigationDelegate = context.coordinator
        
        // スワイプで画面遷移できるようにする
        webView.allowsBackForwardNavigationGestures = true
        
        guard let url = URL(string: urlString) else {
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    func getUrl() -> String {
        let url = webView.url?.absoluteString ?? ""
        return url
    }
    
    // 前のページに戻る
    func goBack() {
        webView.goBack()
    }
    
    // 次のページに進む
    func goForward() {
        webView.goForward()
    }
    
    // ページをリロードする
    func reload() {
        webView.reload()
    }
}
