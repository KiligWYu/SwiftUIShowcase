//
//  TextRendererScreen.swift
//  SwiftUIShowcase
//
//  Created by 𝕶𝖎𝖑𝖎𝖌 on 8/1/24.
//
//  [用 TextRenderer 构建绚丽动感的文字效果](https://fatbobman.com/zh/posts/creating-stunning-dynamic-text-effects-with-textrender/)
//

import SwiftUI

@available(iOS 18.0, *)
struct TextRendererScreen: View {
  var body: some View {
    Form {
      Section {
        ColorfulTextDemo()
      } header: {
        Text("Colorful Text")
      }

      Section {
        AnimatedSineWaveDemo()
      } header: {
        Text("Animated Sine Wave")
      }

      Section {
        ColorfulAttributeDemo()
      } header: {
        Text("Colorful Attribute")
      }

      Section {
        BlurEffectDemo()
      } header: {
        Text("Blur Effect")
      }
    }
    .navigationTitle("Text Renderer")
  }
}

#Preview {
  if #available(iOS 18.0, *) {
    TextRendererScreen()
  }
}

// MARK: - TextLayout Extension

extension Text.Layout {
  var flattenedRuns: some RandomAccessCollection<Text.Layout.Run> {
    flatMap(\.self)
  }

  var flattenedRunSlices: some RandomAccessCollection<Text.Layout.RunSlice> {
    flattenedRuns.flatMap(\.self)
  }
}
