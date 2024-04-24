//
//  SegmentedControl.swift
//  SwiftUIShowcase
//
//  Created by 𝕶𝖎𝖑𝖎𝖌 on 3/24/24.
//

import SwiftUI

struct SegmentedControl<Indicator: View>: View {
  var tabs: [SegmentedTab]
  var height: CGFloat = 45
  var displayAsText = false
  var font: Font = .title3
  var activeTint = Color.blue
  var inactiveTint = Color.gray

  @Binding var activeTab: SegmentedTab
  @ViewBuilder var indicatorView: (CGSize) -> Indicator

  @State private var excessTabWidth: CGFloat = .zero
  @State private var minX: CGFloat = .zero

  var body: some View {
    GeometryReader {
      let size = $0.size
      let containerWidthForEachTab = size.width / CGFloat(tabs.count)

      HStack(spacing: 0) {
        ForEach(tabs, id: \.rawValue) { tab in
          Group {
            if displayAsText {
              Text(tab.rawValue)
            } else {
              Image(systemName: tab.rawValue)
            }
          }
          .font(font)
          .foregroundStyle(activeTab == tab ? activeTint : inactiveTint)
          .animation(.snappy, value: activeTab)
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .contentShape(.rect)
          .onTapGesture {
            if let index = tabs.firstIndex(of: tab),
               let activeIndex = tabs.firstIndex(of: activeTab) {
              activeTab = tab

              withAnimation(.snappy(duration: 0.25, extraBounce: 0), completionCriteria: .logicallyComplete) {
                excessTabWidth = containerWidthForEachTab * CGFloat(index - activeIndex)
              } completion: {
                withAnimation(.snappy(duration: 0.25)) {
                  minX = containerWidthForEachTab * CGFloat(index)
                  excessTabWidth = 0
                }
              }
            }
          }
          .background(alignment: .leading) {
            if tabs.first == tab {
              GeometryReader {
                let size = $0.size

                indicatorView(size)
                  .frame(width: size.width + abs(excessTabWidth), height: size.height)
                  .frame(width: size.width, alignment: excessTabWidth < 0 ? .trailing : .leading)
                  .offset(x: minX)
              }
            }
          }
        }
      }
    }
    .frame(height: height)
  }
}

#Preview {
  SegmentedControl(tabs: SegmentedTab.allCases, activeTab: .constant(.home)) { _ in }
}
