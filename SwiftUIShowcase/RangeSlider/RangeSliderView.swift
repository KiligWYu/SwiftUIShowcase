//
//  RangeSliderView.swift
//  SwiftUIShowcase
//
//  Created by 𝕶𝖎𝖑𝖎𝖌 on 4/26/24.
//

import SwiftUI

struct RangeSliderView: View {
  var range: ClosedRange<CGFloat>
  @Binding var selection: ClosedRange<CGFloat>
  var minimumDistance: CGFloat = 0
  @State private var slider1 = GestureProperties()
  @State private var slider2 = GestureProperties()
  @State private var indicatorWidth = CGFloat.zero
  @State private var isInitial = false

  @State private var isTapSlider1 = false
  @State private var isTapSlider2 = false

  var body: some View {
    GeometryReader {
      let size = $0.size
      let maxSliderWidth = size.width - 30
      let minimumDistance = minimumDistance == 0
        ? 0 : (minimumDistance / (range.upperBound - range.lowerBound)) * maxSliderWidth

      VStack {
        ZStack(alignment: .leading) {
          Capsule()
            .fill(.primary.tertiary)
            .frame(height: 5)

          HStack(spacing: 0) {
            Circle()
              .fill(.primary)
              .frame(width: 15, height: 15)
              .scaleEffect(isTapSlider1 ? 2.0 : 1.0)
              .contentShape(.rect)
              .overlay(alignment: .leading) {
                Rectangle()
                  .fill(.primary)
                  .frame(width: indicatorWidth, height: 5)
                  .offset(x: 15)
              }
              .offset(x: slider1.offset)
              .gesture(
                DragGesture(minimumDistance: 0)
                  .onChanged { value in
                    withAnimation { isTapSlider1 = true }

                    var translation = value.translation.width + slider1.lastStoredOffset
                    translation = min(max(translation, 0), slider2.offset - minimumDistance)
                    slider1.offset = translation

                    calculateNewRange(size)
                  }
                  .onEnded { _ in
                    withAnimation { isTapSlider1 = false }
                    slider1.lastStoredOffset = slider1.offset
                  }
              )

            Circle()
              .fill(.primary)
              .frame(width: 15, height: 15)
              .scaleEffect(isTapSlider2 ? 2.0 : 1.0)
              .contentShape(.rect)
              .offset(x: slider2.offset)
              .gesture(
                DragGesture(minimumDistance: 0)
                  .onChanged { value in
                    withAnimation { isTapSlider2 = true }

                    var translation = value.translation.width + slider2.lastStoredOffset
                    translation = min(max(translation, slider1.offset + minimumDistance), maxSliderWidth)
                    slider2.offset = translation

                    calculateNewRange(size)
                  }
                  .onEnded { _ in
                    withAnimation { isTapSlider2 = false }
                    slider2.lastStoredOffset = slider2.offset
                  }
              )
          }
        }

        HStack {
          Text("\(Int(range.lowerBound))")
          Spacer()
          Text("\(Int(range.upperBound))")
        }
        .font(.caption)
        .foregroundStyle(.secondary)
        .padding(.top, 4)
      }
      .frame(maxHeight: .infinity)
      .task {
        isInitial = true
        try? await Task.sleep(for: .seconds(0))
        let maxWidth = size.width - 30

        let start = selection.lowerBound
          .interpolate(inputRange: [range.lowerBound, range.upperBound],
                       outputRange: [0, maxWidth])
        let end = selection.upperBound
          .interpolate(inputRange: [range.lowerBound, range.upperBound],
                       outputRange: [0, maxWidth])

        slider1.offset = start
        slider1.lastStoredOffset = start

        slider2.offset = end
        slider2.lastStoredOffset = end

        calculateNewRange(size)
      }
    }
    .frame(height: 30)
  }

  private func calculateNewRange(_ size: CGSize) {
    indicatorWidth = slider2.offset - slider1.offset

    let maxWidth = size.width
    let startProgress = slider1.offset / maxWidth
    let endProgress = slider2.offset / maxWidth

    let newRangeStart = range.lowerBound.interpolated(towards: range.upperBound, amount: startProgress)
    let newRangeEnd = range.lowerBound.interpolated(towards: range.upperBound, amount: endProgress)
    selection = newRangeStart...newRangeEnd
  }

  private struct GestureProperties {
    var offset: CGFloat = 0
    var lastStoredOffset: CGFloat = 0
  }
}

#Preview {
  RangeSliderScreen()
}

// MARK: -

extension CGFloat {
  // swiftlint:disable identifier_name
  func interpolate(inputRange: [CGFloat], outputRange: [CGFloat]) -> CGFloat {
    let x = self
    let length = inputRange.count - 1
    if x <= inputRange[0] { return outputRange[0] }

    for index in 1...length {
      let x1 = inputRange[index - 1]
      let x2 = inputRange[index]

      let y1 = outputRange[index - 1]
      let y2 = outputRange[index]

      /// Linear Interpolation Formula: y1 + ( (y2-y1) / (x2-x1)) * (x-x1)
      if x <= inputRange[index] {
        let y = y1 + ((y2 - y1) / (x2 - x1)) * (x - x1)
        return y
      }
    }

    return outputRange[length]
  }
  // swiftlint:enable identifier_name
}
