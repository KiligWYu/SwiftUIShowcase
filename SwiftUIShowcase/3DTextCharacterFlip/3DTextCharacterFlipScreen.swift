//
//  3DTextCharacterFlipScreen.swift
//  SwiftUIShowcase
//
//  Created by 𝕶𝖎𝖑𝖎𝖌 on 3/25/24.
//

import SwiftUI

struct TextCharacterFlipScreen: View {
  let letters = Array("Hello, SwiftUI!")

  @State private var axisX: CGFloat = 1
  @State private var axisY: CGFloat = 0
  @State private var axisZ: CGFloat = 0
  @State private var flipAngle = Double.zero

  var body: some View {
    VStack {
      HStack(spacing: 0) {
        ForEach(0 ..< letters.count, id: \.self) { index in
          Text(String(letters[index]))
            .font(.largeTitle.bold())
            .rotation3DEffect(.degrees(flipAngle),
                              axis: (x: axisX, y: axisY, z: axisZ))
            .animation(.default.delay(Double(index) * 0.1),
                       value: flipAngle)
        }
      }

      Button {
        axisX = 1; axisY = 0; axisZ = 0
        flipAngle += 360
      } label: {
        VStack {
          Text("Flip")
          Text("axis: x = 1, y = 0, z = 0")
            .font(.subheadline)
        }
        .padding(.horizontal, 20)
      }
      .buttonStyle(.borderedProminent)

      Button {
        axisX = 0; axisY = 1; axisZ = 0
        flipAngle += 360
      } label: {
        VStack {
          Text("Flip")
          Text("axis: x = 0, y = 1, z = 0")
            .font(.subheadline)
        }
        .padding(.horizontal, 20)
      }
      .buttonStyle(.borderedProminent)

      Button {
        axisX = 0; axisY = 0; axisZ = 1
        flipAngle += 360
      } label: {
        VStack {
          Text("Flip")
          Text("axis: x = 0, y = 0, z = 1")
            .font(.subheadline)
        }
        .padding(.horizontal, 20)
      }
      .buttonStyle(.borderedProminent)

      Button {
        axisX = 1; axisY = 1; axisZ = 1
        flipAngle += 360
      } label: {
        VStack {
          Text("Flip")
          Text("axis: x = 1, y = 1, z = 1")
            .font(.subheadline)
        }
        .padding(.horizontal, 20)
      }
      .buttonStyle(.borderedProminent)
    }
    .navigationTitle("3D Text Character Flip")
    .toolbar {
      Link(destination: URL(string: "https://www.youtube.com/watch?v=8npuczSgGDk")!) {
        Label("Copyright", systemImage: "c.circle")
          .labelStyle(.iconOnly)
      }
    }
  }
}

#Preview {
  TextCharacterFlipScreen()
}
