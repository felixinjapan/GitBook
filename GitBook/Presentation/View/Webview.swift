//
//  Webview.swift
//  GitBook
//
//  Created by Chon, Felix | Felix | MESD on 2022/11/21.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {

    var url: URL

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        DispatchQueue.main.async {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}
