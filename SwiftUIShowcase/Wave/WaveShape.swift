//
//  WaveShape.swift
//  SwiftUIShowcase
//
//  Created by 𝕶𝖎𝖑𝖎𝖌 on 6/4/24.
//

import SwiftUI

struct WaveShape: Shape, Animatable {
  var time: CGFloat
  var amplitude: CGFloat
  var wavelength: CGFloat
  var animatableData: CGFloat {
    get { time }
    set { time = newValue }
  }

  func path(in rect: CGRect) -> Path {
    var points = [CGPoint]()
    // swiftlint:disable identifier_name
    for i in 0 ..< Int(rect.width) {
      let x = CGFloat(i)
      let y = amplitude * sin(2 * CGFloat.pi / wavelength * x + wavelength * time) + rect.height / 2
      points.append(CGPoint(x: CGFloat(x), y: y))
    }
    // swiftlint:enable identifier_name

    return Path { path in
      path.move(to: points.first!)
      for point in points {
        path.addLine(to: point)
      }
      path
        .addEllipse(in: CGRect(origin: points.last!.applying(CGAffineTransform(translationX: -5, y: -5)),
                               size: CGSize(width: 10, height: 10)))
    }
  }
}
