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
        
        let provider = LPMetadataProvider()
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