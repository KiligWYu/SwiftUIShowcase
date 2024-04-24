//
//  LinearGradient+Ex.swift
//  SwiftUIShowcase
//
//  Created by 𝕶𝖎𝖑𝖎𝖌 on 3/23/24.
//

import SwiftUI

extension LinearGradient {
  init(_ colors: Color...) {
    self.init(
      gradient: Gradient(colors: colors),
      startPoint: .topLeading,
      endPoint: .bottomTrailing
    )
  }
}
