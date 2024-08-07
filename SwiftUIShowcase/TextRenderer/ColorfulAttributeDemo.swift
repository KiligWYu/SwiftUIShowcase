//
//  ColorfulAttributeDemo.swift
//  SwiftUIShowcase
//
//  Created by 𝕶𝖎𝖑𝖎𝖌 on 8/7/24.
//

import SwiftUI

@available(iOS 18.0, *)
struct ColorfulAttributeDemo: View {
  var body: some View {
    let weekly = Text("Fatbobman Swift Weekly")
      .bold()
      .foregroundStyle(.pink)
      .customAttribute(ColorfulAttribute())

    Text("Subscribe \(weekly) now!")
      .textRenderer(ColorfulAttributeRender())
  }
}

struct ColorfulAttribute: TextAttribute {}

struct ColorfulAttributeRender: TextRenderer {
  func draw(layout: Text.Layout, in context: inout GraphicsContext) {
    for (index, slice) in layout.flattenedRunSlices.enumerated() {
      // 检查当前 Slice 是否包含 ColorfulAttribute 属性
      if slice[ColorfulAttribute.self] != nil {
        let degree = Angle.degrees(360 / Double(index + 1))
        var copy = context
        copy.addFilter(.hueRotation(degree))
        copy.draw(slice)
      } else {
        // 无需调整，直接绘制
        context.draw(slice)
      }
    }
  }
}
