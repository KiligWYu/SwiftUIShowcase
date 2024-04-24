//
//  DotProgressView.swift
//  SwiftUIShowcase
//
//  Created by 𝕶𝖎𝖑𝖎𝖌 on 3/23/24.
//

import SwiftUI

struct DotProgressView: View {
  // swiftlint:disable:next identifier_name
  @State private var y: CGFloat = 0

  var body: some View {
    HStack {
      DotView(y: y)
        .animation(.easeInOut(duration: 0.5).repeatForever().delay(0), value: y)
      DotView(y: y)
        .animation(.easeInOut(duration: 0.5).repeatForever().delay(0.2), value: y)
      DotView(y: y)
        .animation(.easeInOut(duration: 0.5).repeatForever().delay(0.4), value: y)
    }
    .onAppear { y = -10 }
  }
}

struct DotView: View {
  // swiftlint:disable:next identifier_name
  var y: CGFloat

  var body: some View {
    Circle()
      .frame(width: 8, height: 8, alignment: .center)
      .opacity(y == 0 ? 0.1 : 1)
      .offset(y: y)
      .foregroundColor(.gray)
  }
}
