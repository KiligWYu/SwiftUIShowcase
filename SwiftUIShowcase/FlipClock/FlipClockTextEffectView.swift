//
//  FlipClockTextEffectView.swift
//  SwiftUIShowcase
//
//  Created by 𝕶𝖎𝖑𝖎𝖌 on 5/29/24.
//

import SwiftUI

struct FlipClockTextEffectView: View {
  @Binding var value: Int
  var size: CGSize
  var fontSize: CGFloat
  var cornerRadius: CGFloat
  var foreground: Color
  var background: Color
  var animationDuration: CGFloat = 0.8

  @State private var currentValue = 0
  @State private var nextValue = 0
  @State private var rotation: CGFloat = 0

  var body: some View {
    let halfHeight = size.height / 2

    ZStack {
      UnevenRoundedRectangle(topLeadingRadius: cornerRadius,
                             topTrailingRadius: cornerRadius,
                             style: .continuous)
        .fill(background.shadow(.inner(radius: 1)))
        .frame(height: halfHeight)
        .overlay(alignment: .top) {
          textView(nextValue)
            .frame(width: size.width, height: size.height)
            .drawingGroup()
        }
        .clipped()
        .frame(maxHeight: .infinity, alignment: .top)

      UnevenRoundedRectangle(topLeadingRadius: cornerRadius,
                             topTrailingRadius: cornerRadius,
                             style: .continuous)
        .fill(background.shadow(.inner(radius: 1)))
        .frame(height: halfHeight)
        .modifier(
          RotationModifier(
            rotation: rotation,
            currentValue: currentValue,
            nextValue: nextValue,
            fontSize: fontSize,
            foreground: foreground,
            size: size
          )
        )
        .clipped()
        .rotation3DEffect(
          .init(degrees: rotation),
          axis: (x: 1.0, y: 0.0, z: 0.0),
          anchor: .bottom,
          anchorZ: 0.01,
          perspective: 0.4
        )
        .frame(maxHeight: .infinity, alignment: .top)
        .zIndex(10)

      UnevenRoundedRectangle(bottomLeadingRadius: cornerRadius,
                             bottomTrailingRadius: cornerRadius,
                             style: .continuous)
        .fill(background.shadow(.inner(radius: 1)))
        .frame(height: halfHeight)
        .overlay(alignment: .bottom) {
          textView(currentValue)
            .frame(width: size.width, height: size.height)
            .drawingGroup()
        }
        .clipped()
        .frame(maxHeight: .infinity, alignment: .bottom)
    }
    .frame(width: size.width, height: size.height)
    .onChange(of: value, initial: true) { oldValue, newValue in
      currentValue = oldValue
      nextValue = newValue

      guard rotation == 0 else {
        currentValue = newValue
        return
      }

      guard oldValue != newValue else { return }

      withAnimation(.easeInOut(duration: animationDuration),
                    completionCriteria: .logicallyComplete) {
        rotation = -180
      } completion: {
        rotation = 0
        currentValue = value
      }
    }
  }

  @ViewBuilder
  private func textView(_ value: Int) -> some View {
    Text("\(value)")
      .font(.system(size: fontSize).bold())
      .foregroundStyle(foreground)
      .lineLimit(1)
  }
}

// MARK: -

private struct RotationModifier: ViewModifier, @preconcurrency Animatable {
  var rotation: CGFloat
  var currentValue: Int
  var nextValue: Int
  var fontSize: CGFloat
  var foreground: Color
  var size: CGSize
  var animatableData: CGFloat {
    get { rotation }
    set { rotation = newValue }
  }

  func body(content: Content) -> some View {
    content
      .overlay(alignment: .top) {
        Group {
          if -rotation > 90 {
            Text("\(nextValue)")
              .font(.system(size: fontSize).bold())
              .foregroundStyle(foreground)
              .scaleEffect(x: 1, y: -1)
              .transition(.identity)
              .lineLimit(1)
          } else {
            Text("\(currentValue)")
              .font(.system(size: fontSize).bold())
              .foregroundStyle(foreground)
              .transition(.identity)
              .lineLimit(1)
          }
        }
        .frame(width: size.width, height: size.height)
        .drawingGroup()
      }
  }
}
