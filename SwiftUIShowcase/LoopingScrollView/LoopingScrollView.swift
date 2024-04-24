//
//  LoopingScrollView.swift
//  SwiftUIShowcase
//
//  Created by 𝕶𝖎𝖑𝖎𝖌 on 4/1/24.
//

import SwiftUI

struct LoopingScrollView<Content: View, Item: RandomAccessCollection>: View where Item.Element: Identifiable {
  var width: CGFloat
  var spacing: CGFloat = 0
  var items: Item
  @ViewBuilder var content: (Item.Element) -> Content

  var body: some View {
    GeometryReader {
      let size = $0.size
      let repeatingCount = width > 0 ? Int((size.width / width).rounded()) + 1 : 1

      ScrollView(.horizontal) {
        LazyHStack(spacing: spacing) {
          ForEach(items) { item in
            content(item)
              .frame(width: width)
          }

          ForEach(0 ..< repeatingCount, id: \.self) { index in
            let item = Array(items)[index % items.count]
            content(item)
              .frame(width: width)
          }
        }
        .background {
          ScrollViewHelper(
            width: width,
            spacing: spacing,
            itemsCount: items.count,
            repeatingCount: repeatingCount
          )
        }
      }
    }
  }
}

// MARK: -

private struct ScrollViewHelper: UIViewRepresentable {
  var width: CGFloat
  var spacing: CGFloat
  var itemsCount: Int
  var repeatingCount: Int

  func makeUIView(context: Context) -> UIView {
    .init()
  }

  func makeCoordinator() -> Coordinator {
    Coordinator(
      width: width,
      spacing: spacing,
      itemsCount: itemsCount,
      repeatingCount: repeatingCount
    )
  }

  func updateUIView(_ uiView: UIView, context: Context) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.06) {
      if let scrollView = uiView.superview?.superview?.superview as? UIScrollView,
         !context.coordinator.isAdded {
        scrollView.delegate = context.coordinator
        context.coordinator.isAdded = true
      }
    }

    context.coordinator.width = width
    context.coordinator.spacing = spacing
    context.coordinator.itemsCount = itemsCount
    context.coordinator.repeatingCount = repeatingCount
  }

  // MARK: -

  class Coordinator: NSObject, UIScrollViewDelegate {
    var width: CGFloat
    var spacing: CGFloat
    var itemsCount: Int
    var repeatingCount: Int

    init(width: CGFloat, spacing: CGFloat, itemsCount: Int, repeatingCount: Int) {
      self.width = width
      self.spacing = spacing
      self.itemsCount = itemsCount
      self.repeatingCount = repeatingCount
    }

    var isAdded = false

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
      guard itemsCount > 0 else { return }

      let minX = scrollView.contentOffset.x
      let mainContentSize = CGFloat(itemsCount) * width
      let spacingSize = CGFloat(itemsCount) * spacing

      if minX > (mainContentSize + spacingSize) {
        scrollView.contentOffset.x -= mainContentSize + spacingSize
      }

      if minX < 0 {
        scrollView.contentOffset.x += mainContentSize + spacingSize
      }
    }
  }
}
