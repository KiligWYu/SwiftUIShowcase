//
//  StackedCardsScreen.swift
//  SwiftUIShowcase
//
//  Created by 𝕶𝖎𝖑𝖎𝖌 on 3/29/24.
//

import SwiftUI

struct StackedCardsScreen: View {
  @State private var isRotationEnabled = true
  @State private var showsIndicator = true

  private var cards = [
    Card(color: .random),
    Card(color: .random),
    Card(color: .random),
    Card(color: .random),
    Card(color: .random),
    Card(color: .random)
  ]

  var body: some View {
    VStack {
      GeometryReader {
        let size = $0.size

        ScrollView(.horizontal) {
          HStack(spacing: 0) {
            ForEach(cards) { card in
              RoundedRectangle(cornerRadius: 15)
                .fill(card.color.gradient)
                .padding(.horizontal, 65)
                .frame(width: size.width)
                .visualEffect { [isRotationEnabled] content, geometryProxy in
                  content
                    .scaleEffect(scale(geometryProxy), anchor: .trailing)
                    .rotationEffect(rotation(geometryProxy, rotation: isRotationEnabled ? 5 : 0))
                    .offset(x: minX(geometryProxy))
                    .offset(x: excessMinX(geometryProxy, offset: isRotationEnabled ? 8 : 10))
                }
                .zIndex(cards.zIndex(card))
            }
          }
          .padding(.vertical, 15)
        }
        .scrollTargetBehavior(.paging)
        .scrollIndicators(showsIndicator ? .visible : .hidden)
        .scrollIndicatorsFlash(trigger: showsIndicator)
      }
      .frame(height: 400)
      .animation(.snappy, value: isRotationEnabled)

      VStack(spacing: 10) {
        Toggle("Rotation Enabled", isOn: $isRotationEnabled)
        Divider()
        Toggle("Shows Scroll Indicator", isOn: $showsIndicator)
      }
      .padding(15)
      .background(.bar, in: RoundedRectangle(cornerRadius: 10))
      .padding(15)

      Spacer(minLength: 0)
    }
    .navigationTitle("Stacked Cards")
    .toolbar {
      Link(destination: URL(string: "https://www.youtube.com/watch?v=NgYyN2YyDd4")!) {
        Label("Visual Effect API - Stacked Cards", systemImage: "c.circle")
          .labelStyle(.iconOnly)
      }
    }
  }

  private nonisolated func minX(_ proxy: GeometryProxy) -> CGFloat {
    let minX = proxy.frame(in: .scrollView(axis: .horizontal)).minX
    return minX < 0 ? 0 : -minX
  }

  private nonisolated func progress(_ proxy: GeometryProxy, limit: CGFloat = 2) -> CGFloat {
    let maxX = proxy.frame(in: .scrollView(axis: .horizontal)).maxX
    let width = proxy.bounds(of: .scrollView(axis: .horizontal))?.width ?? 0
    let progress = maxX / width - 1.0
    let cappedProgress = min(progress, limit)
    return cappedProgress
  }

  private nonisolated func scale(_ proxy: GeometryProxy, scale: CGFloat = 0.1) -> CGFloat {
    1 - (progress(proxy) * scale)
  }

  private nonisolated func excessMinX(_ proxy: GeometryProxy, offset: CGFloat = 10) -> CGFloat {
    progress(proxy) * offset
  }

  private nonisolated func rotation(_ proxy: GeometryProxy, rotation: CGFloat = 5) -> Angle {
    Angle(degrees: progress(proxy) * rotation)
  }
}

#Preview {
  StackedCardsScreen()
}
