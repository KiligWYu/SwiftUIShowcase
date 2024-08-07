//
//  AnimatedSineWaveDemo.swift
//  SwiftUIShowcase
//
//  Created by 𝕶𝖎𝖑𝖎𝖌 on 8/7/24.
//

import SwiftUI

@available(iOS 18.0, *)
struct AnimatedSineWaveDemo: View {
  @State private var offset: Double = 0
  @State private var timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()

  var body: some View {
    Text("Build Visual Effects with TextRenderer!")
      .font(.system(size: 16))
      .textRenderer(AnimatedSineWaveOffsetRender(timeOffset: offset, fontSize: 16))
      .onReceive(timer) { _ in
        if offset > 1_000_000_000_000 {
          offset = 0 // 重置时间偏移
        }
        offset += 10
      }
  }
}

@available(iOS 18.0, *)
struct AnimatedSineWaveOffsetRender: TextRenderer {
  let timeOffset: Double // 时间偏移量
  let fontSize: CGFloat // 字号信息，用于计算 displayPadding

  var displayPadding: EdgeInsets {
    let height = fontSize * 1.2
    return EdgeInsets(top: -height / 2, leading: 0, bottom: 0, trailing: 0) // 调整文本位置
  }

  func sizeThatFits(proposal: ProposedViewSize, text: TextProxy) -> CGSize {
    let originalSize = text.sizeThatFits(proposal)
    return CGSize(width: originalSize.width, height: originalSize.height * 2) // 根据最大振幅调整尺寸
  }

  func draw(layout: Text.Layout, in ctx: inout GraphicsContext) {
    let count = layout.flattenedRunSlices.count // 统计文本布局中所有 RunSlice 的数量
    let width = layout.first?.typographicBounds.width ?? 0 // 获取文本 Line 的宽度
    let height = layout.first?.typographicBounds.rect.height ?? 0 // 获取文本 Line 的高度
    // 遍历每个 RunSlice 及其索引
    for (index, slice) in layout.flattenedRunSlices.enumerated() {
      // 计算当前字符的正弦波偏移量
      let offset = animatedSineWaveOffset(
        forCharacterAt: index,
        amplitude: height / 2, // 振幅设为行高的一半
        wavelength: width,
        phaseOffset: timeOffset,
        totalCharacters: count
      )
      // 创建上下文副本并进行平移
      var copy = ctx
      copy.translateBy(x: 0, y: offset)
      // 在修改后的上下文中绘制当前 RunSlice
      copy.draw(slice)
    }
  }

  /// 根据字符索引计算正弦波偏移量
  private func animatedSineWaveOffset(
    forCharacterAt index: Int,
    amplitude: Double,
    wavelength: Double,
    phaseOffset: Double,
    totalCharacters: Int
  ) -> Double {
    let index = Double(index)
    let position = (index / Double(totalCharacters)) * wavelength
    let radians = ((position + phaseOffset) / wavelength) * 2 * .pi
    return amplitude * sin(radians)
  }
}
