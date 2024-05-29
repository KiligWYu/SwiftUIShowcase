//
//  FlipClockScreen.swift
//  SwiftUIShowcase
//
//  Created by 𝕶𝖎𝖑𝖎𝖌 on 5/29/24.
//

import SwiftUI

struct FlipClockScreen: View {
  @State private var count = 0
  @State private var timer: CGFloat = 0
  @Environment(\.colorScheme) private var colorScheme

  var body: some View {
    HStack(spacing: 10) {
      FlipClockTextEffectView(
        value: .constant(count / 10),
        size: CGSize(width: 100, height: 150),
        fontSize: 90,
        cornerRadius: 20,
        foreground: colorScheme == .light ? .white : .black,
        background: colorScheme == .light ? .black : .white
      )

      FlipClockTextEffectView(
        value: .constant(count % 10),
        size: CGSize(width: 100, height: 150),
        fontSize: 90,
        cornerRadius: 20,
        foreground: colorScheme == .light ? .white : .black,
        background: colorScheme == .light ? .black : .white
      )
    }
    .onReceive(Timer.publish(every: 0.01, on: .current, in: .common).autoconnect()) { _ in
      timer += 0.01
      if timer >= 60 { timer = 0 }
      count = Int(timer)
    }
    .navigationTitle("Flip Clock")
    .toolbar {
      ToolbarItem {
        Link(destination: URL(string: "https://www.youtube.com/watch?v=Lekoc7QS-K4")!) {
          Label("Flip Clock Text Effect", systemImage: "c.circle")
            .labelStyle(.iconOnly)
        }
      }
    }
  }
}

#Preview {
  FlipClockScreen()
}
