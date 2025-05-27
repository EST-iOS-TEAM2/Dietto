//
//  ArticleView.swift
//  Dietto
//
//  Created by 안세훈 on 5/26/25.
//

import SwiftUI

struct ArticleView: View {
    var body: some View {
        ZStack{
            Color.backGround.ignoresSafeArea(edges: .all)
            VStack{
                HStack {
                    //MARK: - 로고
                    Text("Dietto")
                        .font(.NerkoOne40)
                        .foregroundStyle(.text)
                    Spacer()
                    
                    PillText(text: "edit")
                }
                .padding([.leading, .trailing], 16)
                

                Spacer()
                
                ContainerView(paddingSize: 16, height: 1000) {
                    Text("asd")
                }
            }
        }
    }
}

#Preview {
    ArticleView()
}
