//
//  AnimatedPageIndicatorScreen.swift
//  SwiftUIShowcase
//
//  Created by 𝕶𝖎𝖑𝖎𝖌 on 3/28/24.
//

import SwiftUI

struct AnimatedPageIndicatorScreen: View {
  @State private var colors: [Color] = [.red, .green, .blue, .random]
  @State private var opacityEffect = true
  @State private var clipEdges = false

  var body: some View {
    VStack {
      ScrollView(.horizontal) {
        LazyHStack(spacing: 0) {
          ForEach(colors, id: \.self) { color in
            RoundedRectangle(cornerRadius: 25)
              .fill(color.gradient)
              .padding(.horizontal, 5)
              .containerRelativeFrame(.horizontal)
          }
        }
        .scrollTargetLayout()
        .overlay(alignment: .bottom) {
          PagingIndicator(
            activeTint: .white,
            inactiveTint: .black.opacity(0.25),
            opacityEffect: opacityEffect,
            clipEdges: clipEdges
          )
        }
      }
      .scrollTargetBehavior(.viewAligned)
      .scrollIndicators(.hidden)
      .frame(height: 220)
      .safeAreaPadding(.vertical, 15)
      .safeAreaPadding(.horizontal, 25)

      optionsView
    }
    .navigationTitle("Custom Indicator")
    .toolbar {
      Link(destination: URL(string: "https://www.youtube.com/watch?v=hvD_AafLGc0")!) {
        Label("SwiftUI Animated Paging Indicators", systemImage: "c.circle")
          .labelStyle(.iconOnly)
      }
    }
  }

  @MainActor @ViewBuilder
  private var optionsView: some View {
    List {
      Section {
        Toggle("Opacity Effect", isOn: $opacityEffect)
        Toggle("Clip Edges", isOn: $clipEdges)
        Button {
          colors.append(.random)
        } label: {
          Text("Add Item")
        }
      } header: {
        Text("Options")
      }
    }
    .clipShape(.rect(cornerRadius: 15))
    .padding(15)
  }
}

#Preview {
  AnimatedPageIndicatorScreen()
}
