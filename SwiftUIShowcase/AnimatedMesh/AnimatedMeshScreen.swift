//
//  AnimatedMeshScreen.swift
//  SwiftUIShowcase
//
//  Created by 𝕶𝖎𝖑𝖎𝖌 on 7/30/24.
//
//  ChaoCode - [日常學習交流大會 # 2 feat. Harry Ng](https://www.youtube.com/watch?v=QNai-rQtfqQ&t=41s)
//  𝕏 - [@dankuntz](https://x.com/dankuntz/status/1800290461351035346)
//

import SwiftUI

@available(iOS 18.0, *)
struct AnimatedMeshScreen: View {
  @State private var time: Float = 0
  @State private var timer: Timer?

  private var points: [SIMD2<Float>] {
    [
      [0.0, 0.0], [0.5, 0.0], [1.0, 0.0],

      [sinInRange(-0.8...(-0.2), 0.439, 0.342, time), sinInRange(0.3...0.7, 3.42, 0.984, time)],
      [sinInRange(0.1...0.8, 0.239, 0.084, time), sinInRange(0.2...0.8, 5.21, 0.242, time)],
      [sinInRange(1.0...1.5, 0.939, 0.084, time), sinInRange(0.4...0.8, 0.25, 0.642, time)],

      [sinInRange(-0.8...0.0, 1.439, 0.442, time), sinInRange(1.4...1.9, 3.42, 0.984, time)],
      [sinInRange(0.3...0.6, 0.339, 0.784, time), sinInRange(1.0...1.2, 1.22, 0.772, time)],
      [sinInRange(1.0...1.5, 0.939, 0.056, time), sinInRange(1.3...1.7, 0.47, 0.342, time)]
    ]
  }

  private var colors: [Color] = [
    .clear, .clear, .clear,
    .yellow.mix(with: .white, by: 0.2), .pink.mix(with: .white, by: 0.5), .indigo.mix(with: .white, by: 0.5),
    .clear, .clear, .clear
  ]

  var body: some View {
    MeshGradient(width: 3, height: 3, points: points, colors: colors)
      .ignoresSafeArea()
      .onAppear {
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
          MainActor.assumeIsolated {
            time += 0.02
          }
        }
      }
      .onDisappear {
        self.timer?.invalidate()
        self.timer = nil
      }
      .navigationTitle("Animated Mesh")
  }

  private func sinInRange(
    _ range: ClosedRange<Float>,
    _ offset: Float,
    _ timeScale: Float,
    _ time: Float
  ) -> Float {
    let amplitude = (range.upperBound - range.lowerBound) / 2
    let midPoint = (range.upperBound + range.lowerBound) / 2
    return midPoint + amplitude * sin(timeScale * time + offset)
  }
}

#Preview {
  if #available(iOS 18.0, *) {
    AnimatedMeshScreen()
  }
}
