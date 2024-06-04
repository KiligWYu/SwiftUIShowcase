//
//  WaveView.swift
//  SwiftUIShowcase
//
//  Created by 𝕶𝖎𝖑𝖎𝖌 on 6/4/24.
//

import SwiftUI

struct WaveView: View {
  var body: some View {
    TimelineView(.animation) { timeline in
      Canvas { context, size in
        let angle = Angle.degrees(timeline.date.timeIntervalSinceReferenceDate.remainder(dividingBy: 4) * 180)
        let cos = cos(angle.radians) * 25
        let sin = sin(angle.radians) * 19

        let width = size.width
        let height = size.height

        context.fill(Path(CGRect(origin: .zero, size: size)), with: .color(.white))

        let path = Path { path in
          path.move(to: CGPoint(x: 0, y: size.height / 2))

          path.addCurve(to: CGPoint(x: width, y: size.height / 2),
                        control1: CGPoint(x: width * 0.4, y: height * 0.2 - cos),
                        control2: CGPoint(x: width * 0.6, y: height * 0.8 + sin))
        }

        context.stroke(
          path,
          with: .linearGradient(Gradient(colors: [.red, .blue]),
                                startPoint: .zero,
                                endPoint: CGPoint(x: size.width, y: size.height)), lineWidth: 2
        )
      }
    }
  }
}

#Preview {
  WaveView()
}
