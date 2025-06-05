//
//  LinkRow.swift
//  Dietto
//
//  Created by 안정흠 on 5/27/25.
//


import SwiftUI
import LinkPresentation

struct LinkRow : UIViewRepresentable {
    
    var previewURL:URL
    
    func makeUIView(context: Context) -> LPLinkView {
        let view = LPLinkView(url: previewURL)
        
        let provider = LPMetadataProvider() // Provider Fetch작업을 VM에서 미리하는 방식이 더 좋을거 같음 경고가 엄청뜬다 (nil경고, 주소유효성 경고 등등)
        provider.startFetchingMetadata(for: previewURL) { (metadata, error) in
            if let md = metadata {
                DispatchQueue.main.async {
                    view.metadata = md
                    view.sizeToFit()
                }
            }
            else if error != nil
            {
                let md = LPLinkMetadata()
                md.title = "Custom title"
                view.metadata = md
                view.sizeToFit()
            }
        }
        
        return view
    }
    
    func updateUIView(_ view: LPLinkView, context: Context) {
        // New instance for each update
    }
}
