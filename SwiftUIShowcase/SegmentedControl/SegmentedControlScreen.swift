//
//  SegmentedControlScreen.swift
//  SwiftUIShowcase
//
//  Created by 𝕶𝖎𝖑𝖎𝖌 on 3/24/24.
//

import SwiftUI

enum SegmentedTab: String, CaseIterable {
  case home = "house.fill"
  case favourites = "suit.heart.fill"
  case notifications = "bell.fill"
  case profile = "person.fill"
}

// MARK: -

struct SegmentedControlScreen: View {
  @State private var activeTab = SegmentedTab.home
  @State private var type2 = false

  var body: some View {
    VStack(spacing: 15) {
      SegmentedControl(
        tabs: SegmentedTab.allCases,
        height: 35,
        displayAsText: false,
        font: .body,
        activeTint: type2 ? .white : .primary,
        inactiveTint: .gray.opacity(0.5),
        activeTab: $activeTab
      ) { size in
        RoundedRectangle(cornerRadius: type2 ? 30 : 0)
          .fill(.blue)
          .frame(height: type2 ? size.height : 4)
          .padding(.horizontal, type2 ? 0 : 10)
          .frame(maxHeight: .infinity, alignment: .bottom)
      }
      .padding(.top, type2 ? 0 : 10)
      .background {
        RoundedRectangle(cornerRadius: type2 ? 30 : 0)
          .fill(.ultraThinMaterial)
          .ignoresSafeArea()
      }
      .padding(.horizontal, type2 ? 15 : 0)

      Toggle("Segmented Control Type - 2", isOn: $type2)
        .padding(10)
        .background(.regularMaterial, in: .rect(cornerRadius: 10))
        .padding(15)

      Spacer()
    }
    .padding(.vertical, type2 ? 15 : 0)
    .animation(.snappy, value: type2)
    .navigationTitle("Segmented Control")
    .toolbarBackground(.hidden, for: .navigationBar)
    .toolbar {
      Link(destination: URL(string: "https://www.youtube.com/watch?v=Qnq9_l1M8Fg")!) {
        Label("Copyright", systemImage: "c.circle")
          .labelStyle(.iconOnly)
      }
    }
  }
}

#Preview {
  SegmentedControlScreen()
}
