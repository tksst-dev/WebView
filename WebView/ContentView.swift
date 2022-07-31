//
//  ContentView.swift
//  WebView
//
//  Created by 習田武志 on 2022/07/30.
//

import SwiftUI

struct ContentView: View {
    @State var showSafari = false
    @State var showWebKit = false
    
    var body: some View {
        VStack {
            Button("Safari") {
                showSafari = true
                showWebKit = false
            }
            Button("WebKit") {
                showSafari = false
                showWebKit = true
            }
            .sheet(isPresented: self.$showSafari, content: {
                if let webUrl = URL(string: "https://www.google.co.jp/") {
                    // SafariViewを表示する
                    SafariView(url: webUrl)
                        // 画面下部がセーフエリア外までいっぱいになるように指定
                        .edgesIgnoringSafeArea(.bottom)
                        
                }
            })
            
            .sheet(isPresented: self.$showWebKit, content: {
                let configuration = WKWebViewConfiguration()
                let processPool = WKProcessPool()
                configuration.processPool = processPool

                // WebKitViewを表示する
                var webView = WebView(urlString: "https://www.google.co.jp/")
                webView.edgesIgnoringSafeArea(.bottom)

                let cookies: [HTTPCookie]
                for cookie in cookies {
                  webView.configuration.websiteDataStore.httpCookieStore.setCookie(cookie)
                }

                webView.load(request)
                
                
                
//                let webView = WKWebView(frame: .zero, configuration: configuration)
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
