//
//  ContentView2.swift
//  WebView
//
//  Created by 習田武志 on 2022/07/30.
//

import SwiftUI

struct ContentView2: View {
    private var webView = WebView(urlString: "https://www.google.co.jp/")
    
    var body: some View {
        VStack() {
            webView
            
            HStack {
                Spacer()
                
                Button(action: {
                    webView.goBack()
                }) {
                    Image(systemName: "chevron.backward")
                }
                .font(.title3)
                .padding(15)
                
                Spacer()
                
                Button(action: {
                    webView.goForward()
                }) {
                    Image(systemName: "chevron.forward")
                        .font(.title3)
                        .padding(15)
                }
                
                Spacer()
                
                Button(action: {
                    webView.reload()
                }) {
                    Image(systemName: "arrow.counterclockwise")
                        .font(.title3)
                        .padding(15)
                }
                
                Spacer()
            }
            .background(Color(red: 0.9, green: 0.9, blue: 0.9))
        }
    }
}

struct ContentView2_Previews: PreviewProvider {
    static var previews: some View {
        ContentView2()
    }
}
