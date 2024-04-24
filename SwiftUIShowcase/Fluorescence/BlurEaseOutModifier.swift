//
//  BlurEaseOutModifier.swift
//  SwiftUIShowcase
//
//  Created by 𝕶𝖎𝖑𝖎𝖌 on 4/17/24.
//

import SwiftUI

private struct BlurEaseOutModifier: ViewModifier {
  public let isIdentity: Bool
  public var intensity: CGFloat

  public func body(content: Content) -> some View {
    content
      .blur(radius: isIdentity ? intensity : 0)
      .opacity(isIdentity ? 0 : 1)
  }
}

public extension AnyTransition {
  static var blur: AnyTransition {
    .blur()
  }

  static var blurWithoutScale: AnyTransition {
    .modifier(
      active: BlurEaseOutModifier(isIdentity: true, intensity: 5),
      identity: BlurEaseOutModifier(isIdentity: false, intensity: 5)
    )
  }

  static func blur(
    intensity: CGFloat = 5,
    scale: CGFloat = 0.9,
    scaleAnimation animation: Animation = .spring()
  ) -> AnyTransition {
    .scale(scale: scale)
      .animation(animation)
      .combined(
        with: .modifier(
          active: BlurEaseOutModifier(isIdentity: true, intensity: intensity),
          identity: BlurEaseOutModifier(isIdentity: false, intensity: intensity)
        )
      )
  }
}
