//
//  FlowLayout.swift
//  Dietto
//
//  Created by 안세훈 on 5/15/25.
//


import SwiftUI

/// iOS 16+ ㅇㅇ
struct FlowLayout: Layout {
    var spacing: CGFloat? = nil
    var lineSpacing: CGFloat = 10.0
    @Binding var contentHeight: CGFloat //전체 높이 전달
    
    struct Cache {
        var sizes: [CGSize] = []
        var spacing: [CGFloat] = []
        var totalHeight: CGFloat = 0.0 //연산용 cache 높이
    }
    
    func makeCache(subviews: Subviews) -> Cache {
        let sizes = subviews.map { $0.sizeThatFits(.unspecified) } //서브뷰들의 크기
        let spacing: [CGFloat] = subviews.indices.map { index in
            guard index < subviews.count - 1 else { return 0 }
            return subviews[index].spacing.distance(
                to: subviews[index + 1].spacing,
                along: .horizontal
            )
        }
        return Cache(sizes: sizes, spacing: spacing)
    }
    
    func sizeThatFits(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout Cache
    ) -> CGSize {
        var totalHeight: CGFloat = 0
        var lineWidth: CGFloat = 0
        var lineHeight: CGFloat = 0
        let maxWidth = proposal.width ?? .infinity
        
        for index in subviews.indices {
            let size = cache.sizes[index]
            let spacingValue = spacing ?? cache.spacing[index]
            
            let proposedLineWidth = lineWidth == 0 ? size.width : lineWidth + spacingValue + size.width
            
            if proposedLineWidth > maxWidth {
                totalHeight += lineHeight + lineSpacing
                lineWidth = size.width
                lineHeight = size.height
            } else {
                if lineWidth != 0 {
                    lineWidth += spacingValue
                }
                lineWidth += size.width
                lineHeight = max(lineHeight, size.height)
            }
        }
        
        totalHeight += lineHeight
        
        DispatchQueue.main.async {
            withAnimation(.bouncy) {
                self.contentHeight = totalHeight
            }
            //            self.contentHeight = totalHeight
        }
        
        return CGSize(width: maxWidth, height: totalHeight)
    }
    
    func placeSubviews(
        in bounds: CGRect,
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout Cache
    ) {
        var lineX = bounds.minX
        var lineY = bounds.minY
        var lineHeight: CGFloat = 0
        let maxWidth = proposal.width ?? bounds.width
        
        for index in subviews.indices {
            let size = cache.sizes[index]
            let spacingValue = spacing ?? cache.spacing[index]
            
            let proposedX = lineX == bounds.minX ? lineX + size.width : lineX + spacingValue + size.width
            
            if proposedX - bounds.minX > maxWidth {
                lineY += lineHeight + lineSpacing
                lineX = bounds.minX
                lineHeight = 0
            }
            
            if lineX != bounds.minX {
                lineX += spacingValue
            }
            
            subviews[index].place(
                at: CGPoint(x: lineX, y: lineY),
                anchor: .topLeading,
                proposal: ProposedViewSize(size)
            )
            
            lineX += size.width
            lineHeight = max(lineHeight, size.height)
        }
    }
}
