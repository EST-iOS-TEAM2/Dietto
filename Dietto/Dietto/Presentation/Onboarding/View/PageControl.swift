//
//  PageControl.swift
//  Dietto
//
//  Created by 안세훈 on 5/25/25.
//

import SwiftUI

struct PageControl: View {
    
    @Binding var currentPage: Int
    
    var numberOfPages: Int
    
    var body: some View {
        VStack(spacing: 20) {
            HStack(spacing: 8) {
                ForEach(0..<numberOfPages, id: \.self) { pagingIndex in
                    let isCurrentPage = currentPage == pagingIndex
                    let height = 8.0
                    let width = isCurrentPage ? height * 2 : height
                    
                    Capsule()
                        .fill(isCurrentPage ? .accent : .gray.opacity(0.5))
                        .frame(width: width, height: height)
                }
            }
            .animation(.linear, value: currentPage)
            //애니메이션
        }
    }
}

#Preview {
    PageControl(currentPage: .constant(0), numberOfPages: 2)
}
