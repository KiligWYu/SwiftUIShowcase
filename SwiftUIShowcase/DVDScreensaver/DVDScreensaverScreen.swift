//
//  DVDScreensaverScreen.swift
//  SwiftUIShowcase
//
//  Created by 𝕶𝖎𝖑𝖎𝖌 on 3/27/24.
//

import SwiftUI

struct DVDScreensaverScreen: View {
  @State private var position = CGPoint.zero
  private let canvasSize = UIScreen.main.bounds.size
  private let imageSize = CGSize(width: 128, height: 76)
  private let image = Image(.dvdLogo)
  private let framesPerSecond: Double = 1 / 30
  @State private var velocity = CGVector.zero
  @State private var imageColor = Color.random

  var body: some View {
    Canvas { [position] context, size in
      context.fill(Path(CGRect(origin: .zero, size: size)), with: .color(.black))

      var image = context.resolve(image)
      image.shading = .color(imageColor)
      context.draw(
        image,
        in: CGRect(x: position.x, y: position.y, width: imageSize.width, height: imageSize.height)
      )
    }
    .onAppear {
      position = CGPoint(x: (canvasSize.width - imageSize.width) / 2,
                         y: (canvasSize.height - imageSize.height) / 2)
      velocity.dx = CGFloat(
        Int.random(in: 1...5) * (Int.random(in: 1...10).isMultiple(of: 2) ? 1 : -1)
      )
      velocity.dy = CGFloat(
        Int.random(in: 1...5) * (Int.random(in: 1...10).isMultiple(of: 2) ? 1 : -1)
      )
    }
    .onReceive(Timer.publish(every: framesPerSecond, on: .main, in: .common).autoconnect()) { _ in
      position.x += velocity.dx
      position.y += velocity.dy

      if position.x + imageSize.width >= canvasSize.width || position.x <= 0 {
        velocity.dx *= -1
        imageColor = Color.random
      }

      if position.y + imageSize.height >= canvasSize.height || position.y <= 0 {
        velocity.dy *= -1
        imageColor = Color.random
      }
    }
    .ignoresSafeArea()
    .toolbar {
      Link(destination:
        URL(string: "https://digitalbunker.dev/dvd-screensaver-swiftui/")!
      ) {
        Label("Recreating The DVD Screensaver In SwiftUI", systemImage: "link.circle")
          .labelStyle(.iconOnly)
      }
    }
  }
}

#Preview {
  DVDScreensaverScreen()
}
