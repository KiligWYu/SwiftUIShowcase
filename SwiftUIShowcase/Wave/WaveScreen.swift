//
//  WaveScreen.swift
//  SwiftUIShowcase
//
//  Created by 𝕶𝖎𝖑𝖎𝖌 on 6/3/24.
//
//  How to create Sound Wave Animation with TimelineView and Canvas in SwiftUI
//  https://holyswift.app/how-to-create-animation-with-swiftui-canvas-timelineview/
//
//  SwiftUI 学习 (6)-SwiftUI 动画入门下下
//  https://juejin.cn/post/7038390705718296584
//

import SwiftUI

struct WaveScreen: View {
  @State var frameSize = CGFloat(20)
  @State var animation = false

  var body: some View {
    VStack(spacing: 50) {
      WaveView()
        .frame(width: 200, height: 150)

      WaveShape(
        time: animation ? 0.5 : 0,
        amplitude: 60,
        wavelength: 200
      )
      .stroke(LinearGradient(.random, .random, .random, .random), lineWidth: 7)
      .frame(maxWidth: .infinity)
      .frame(height: 200)
      .onAppear {
        withAnimation(.linear(duration: 60).repeatForever(autoreverses: false)) {
          self.animation.toggle()
        }
      }
    }
    .navigationTitle("Wave")
  }
}

#Preview {
  WaveScreen()
}
