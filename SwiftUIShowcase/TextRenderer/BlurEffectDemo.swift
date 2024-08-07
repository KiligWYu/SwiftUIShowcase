//
//  BlurEffectDemo.swift
//  SwiftUIShowcase
//
//  Created by 𝕶𝖎𝖑𝖎𝖌 on 8/7/24.
//

import SwiftUI

@available(iOS 18.0, *)
struct BlurEffectDemo: View {
  var body: some View {
    let weekly = Text("Fatbobman Swift Weekly")
      .bold()
      .foregroundStyle(.pink)
      .customAttribute(BlurAttribute())

    Text("Subscribe \(weekly) now!")
      .textRenderer(BlurEffect())
  }
}

struct BlurAttribute: TextAttribute {}

struct BlurEffect: TextRenderer {
  func draw(layout: Text.Layout, in ctx: inout GraphicsContext) {
    for run in layout.flattenedRuns {
      if run[BlurAttribute.self] != nil {
        // 对具有 BlurAttribute 的 Run 应用模糊效果
        var blurContext = ctx
        let radius = run.typographicBounds.rect.height / 5
        blurContext.addFilter(.blur(radius: radius))
        blurContext.draw(run)
      }
      // 绘制所有 Run，不论是否添加模糊
      ctx.draw(run)
    }
  }
}
