//
//  HueRotationEffectScreen.swift
//  SwiftUIShowcase
//
//  Created by 𝕶𝖎𝖑𝖎𝖌 on 5/8/24.
//

import SwiftUI

struct HueRotationEffectScreen: View {
  var body: some View {
    VStack {
      Spacer()

      Image(.wwdc24Invite)
        .resizable()
        .scaledToFit()
        .phaseAnimator([false, true]) { wwdc24, chromaRotate in
          wwdc24
            .hueRotation(.degrees(chromaRotate ? 420 : 0))
        } animation: { _ in
          .easeInOut(duration: 2)
        }
    }
    .ignoresSafeArea()
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .preferredColorScheme(.dark)
    .navigationTitle("Hue Rotation Effect")
    .toolbar {
      ToolbarItem {
        Link(destination: URL(string: "https://github.com/amosgyamfi/open-swiftui-animations")!) {
          Label("Hue Rotation Effect With Phase Animator", systemImage: "c.circle")
            .labelStyle(.iconOnly)
        }
      }
    }
  }
}

#Preview {
  HueRotationEffectScreen()
}
