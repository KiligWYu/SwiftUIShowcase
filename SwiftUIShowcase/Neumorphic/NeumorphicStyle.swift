//
//  NeumorphicStyle.swift
//  SwiftUIShowcase
//
//  Created by 𝕶𝖎𝖑𝖎𝖌 on 3/23/24.
//

import SwiftUI

extension View {
  func neumorphicStyle() -> some View {
    padding(30)
      .frame(maxWidth: .infinity)
      .background(Color.offWhite)
      .cornerRadius(20)
      .shadow(
        color: Color.black.opacity(0.2),
        radius: 10,
        x: 10,
        y: 10
      )
      .shadow(
        color: Color.white.opacity(0.7),
        radius: 10,
        x: -5,
        y: -5
      )
  }
}
