//
//  LoopingScrollViewScreen.swift
//  SwiftUIShowcase
//
//  Created by 𝕶𝖎𝖑𝖎𝖌 on 4/1/24.
//

import SwiftUI

struct LoopingScrollViewScreen: View {
  @State private var items = [
    LoopingScrollViewModel(),
    LoopingScrollViewModel(),
    LoopingScrollViewModel(),
    LoopingScrollViewModel()
  ]

  var body: some View {
    ScrollView(.vertical) {
      VStack {
        GeometryReader {
          let size = $0.size
          LoopingScrollView(width: size.width, items: items) { item in
            RoundedRectangle(cornerRadius: 15)
              .fill(item.color.gradient)
              .padding(.horizontal, 15)
          }
          .scrollTargetBehavior(.paging)
        }
        .frame(height: 220)
      }
      .padding(.vertical, 15)
    }
    .scrollIndicators(.hidden)
    .navigationTitle("Looping Scrollview")
    .toolbar {
      Link(destination: URL(string: "https://www.youtube.com/watch?v=lyuo59840qs")!) {
        Label("SwiftUI: Infinite Looping ScrollView", systemImage: "c.circle")
          .labelStyle(.iconOnly)
      }
    }
  }
}

#Preview {
  LoopingScrollViewScreen()
}
