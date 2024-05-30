//
//  HackerTextEffectScreen.swift
//  SwiftUIShowcase
//
//  Created by 𝕶𝖎𝖑𝖎𝖌 on 5/30/24.
//

import SwiftUI

struct HackerTextEffectScreen: View {
  private let texts = [
    "Hello, SwiftUI!",
    "The quick brown fox jumps over the lazy dog and runs away.",
    "How much wood would a woodchuck chuck if a woodchuck could chuck wood?",
    "A woodchuck woodchuck as much wood is a woodchuck could chuck wood."
  ]
  @State private var text = "Hello, SwiftUI!"
  @State private var trigger: Bool = false
  @State private var transition = 1
  @State private var speed: CGFloat = 0.06

  var body: some View {
    VStack(alignment: .leading, spacing: 20) {
      HackerTextView(text: text,
                     trigger: trigger,
                     transition:
                     transition == 0 ? .identity : transition == 1 ? .interpolate : .numericText(),
                     speed: speed)
        .font(.title3)
        .padding(.horizontal, 20)
        .frame(height: 250, alignment: .top)

      VStack(spacing: 30) {
        Picker(selection: $transition) {
          Text("Identity")
            .tag(0)
          Text("Interpolate")
            .tag(1)
          Text("NumericText")
            .tag(2)
        } label: {
          Text("Content transition style")
        }
        .pickerStyle(.segmented)

        Text("Speed:")
          .font(.callout)
          .foregroundStyle(.gray)
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.bottom, -15)

        Slider(value: $speed, in: 0.01 ... 0.1)

        Button {
          text = texts.randomElement()!
          trigger.toggle()
        } label: {
          Text("Trigger")
            .font(.title3.bold())
            .padding(.horizontal, 15)
            .padding(.vertical, 2)
        }
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.capsule)
      }
      .padding(15)
      .background(.bar, in: .rect(cornerRadius: 25))
      .padding(.horizontal, 20)
    }
    .navigationTitle("Hacker Text Effect")
    .toolbar {
      Link(destination: URL(string: "https://www.youtube.com/watch?v=T5aUgq8GKnA")!) {
        Label("Hacker Text Effect", systemImage: "c.circle")
          .labelStyle(.iconOnly)
      }
    }
  }
}

#Preview {
  HackerTextEffectScreen()
}
