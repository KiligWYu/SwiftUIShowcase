//
//  PagingIndicator.swift
//  SwiftUIShowcase
//
//  Created by 𝕶𝖎𝖑𝖎𝖌 on 3/28/24.
//

import SwiftUI

struct PagingIndicator: View {
  var activeTint = Color.primary
  var inactiveTint = Color.primary.opacity(0.25)
  var opacityEffect = true
  var clipEdges = false

  var body: some View {
    GeometryReader {
      let width = $0.size.width
      if let scrollViewWidth = $0.bounds(of: .scrollView(axis: .horizontal))?.width,
         scrollViewWidth > 0 {
        let minX = $0.frame(in: .scrollView(axis: .horizontal)).minX
        let totalPages = Int(width / scrollViewWidth)
        let freeProgress = -minX / scrollViewWidth
        let clippedProgress = min(max(freeProgress, 0), CGFloat(totalPages - 1))
        let progress = clipEdges ? clippedProgress : freeProgress
        let activeIndex = Int(progress)
        let nextIndex = Int(progress.rounded(.awayFromZero))
        let indicatorProgress = progress - CGFloat(activeIndex)
        let currentPageWidth = 18 - (indicatorProgress * 18)
        let nextPageWidth = indicatorProgress * 18

        HStack(spacing: 10) {
          ForEach(0 ..< totalPages, id: \.self) { index in
            Capsule()
              .fill(.clear)
              .frame(
                width: 8 + (
                  activeIndex == index
                    ? currentPageWidth
                    : nextIndex == index ? nextPageWidth : 0),
                height: 8
              )
              .overlay {
                ZStack {
                  Capsule()
                    .fill(inactiveTint)

                  Capsule()
                    .fill(activeTint)
                    .opacity(
                      opacityEffect
                        ? (activeIndex == index
                          ? 1 - indicatorProgress
                          : (nextIndex == index ? indicatorProgress : 0))
                        : 1
                    )
                }
              }
          }
        }
        .frame(width: scrollViewWidth)
        .offset(x: -minX)
      }
    }
    .frame(height: 30)
  }
}

#Preview {
  PagingIndicator()
}
