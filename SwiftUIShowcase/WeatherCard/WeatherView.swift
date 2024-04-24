//
//  WeatherView.swift
//  Effects
//
//  Created by 𝕶𝖎𝖑𝖎𝖌 on 1/25/24.
//

import SwiftUI

struct WeatherView: View {
  @State private var coordinateSpaceName = UUID()

  var body: some View {
    VStack {
      ScrollView {
        LazyVStack {
          ForEach(0 ..< 20) { index in
            CardView(index: index, coordinateSpace: .named(coordinateSpaceName))
          }

          Color.clear
            .frame(height: 34)
        }
      }
      .coordinateSpace(.named(coordinateSpaceName))
      .clipShape(.rect(cornerSize: .init(width: 8, height: 8), style: .continuous))
      .padding(.top, 8)
      .padding(.horizontal, 8)
      .ignoresSafeArea(.all, edges: .bottom)
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        Link(destination: URL(string: "https://gist.github.com/unixzii/540f3755862d0d437bda3928e59de871")!) {
          Label("Copyright", systemImage: "c.circle")
            .labelStyle(.iconOnly)
        }
      }
    }
    .background(Image(.weatherBackground))
  }
}
