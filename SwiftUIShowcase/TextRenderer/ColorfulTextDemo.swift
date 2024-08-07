//
//  ColorfulTextDemo.swift
//  SwiftUIShowcase
//
//  Created by 𝕶𝖎𝖑𝖎𝖌 on 8/7/24.
//

import SwiftUI

@available(iOS 18.0, *)
struct ColorfulTextDemo: View {
  var body: some View {
    let swift = Image(systemName: "swift")
    Text("Hello ♥️\(swift)")
      .font(.title)
      .fontWeight(.heavy)
      .foregroundStyle(Color.red)
      .textRenderer(ColorfulRender())
  }
}

struct ColorfulRender: TextRenderer {
  func draw(layout: Text.Layout, in ctx: inout GraphicsContext) {
    for (index, slice) in layout.flattenedRunSlices.enumerated() {
      let degree = Angle.degrees(Double(index) * 30)
      var copy = ctx
      copy.addFilter(.hueRotation(degree))
      copy.draw(slice)
    }
  }
}
