//
//  WheelPickerView.swift
//  SwiftUIShowcase
//
//  Created by 𝕶𝖎𝖑𝖎𝖌 on 3/23/24.
//

import SwiftUI

struct WheelPickerView: View {
  var config: Config
  @Binding var value: CGFloat
  @State private var isLoad = false

  var body: some View {
    GeometryReader {
      let size = $0.size
      let horizontalPadding = size.width / 2

      ScrollView(.horizontal) {
        HStack(spacing: config.spacing) {
          let totalSteps = config.steps * config.count

          ForEach(0 ... totalSteps, id: \.self) { index in
            let remainder = index % config.steps
            Divider()
              .background(remainder == 0 ? Color.primary : .gray)
              .frame(height: remainder == 0 ? 20 : 10, alignment: .center)
              .frame(maxHeight: 20, alignment: .bottom)
              .overlay(alignment: .bottom) {
                if remainder == 0, config.showText {
                  Text("\((index / config.steps) * config.multiplier)")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .textScale(.secondary)
                    .fixedSize()
                    .offset(y: 20)
                }
              }
          }
        }
        .frame(height: size.height)
        .scrollTargetLayout()
      }
      .scrollIndicators(.hidden)
      .scrollTargetBehavior(.viewAligned)
      .scrollPosition(id: .init(get: {
        let position: Int? = isLoad ? (Int(value) * config.steps) / config.multiplier : nil
        return position
      }, set: { newValue in
        if let newValue {
          value = CGFloat(newValue) / CGFloat(config.steps) * CGFloat(config.multiplier)
        }
      }))
      .overlay(alignment: .center, content: {
        Rectangle()
          .frame(width: 1, height: 40)
          .padding(.bottom, 20)
      })
      .safeAreaPadding(.horizontal, horizontalPadding)
      .onAppear {
        if !isLoad {
          isLoad = true
        }
      }
    }
  }

  struct Config: Equatable {
    var count: Int
    var steps = 10
    var spacing: CGFloat = 5
    var multiplier = 1
    var showText = true
  }
}

#Preview {
  WheelPickerView(config: WheelPickerView.Config(count: 30), value: .init(get: { 0 }, set: { _ in }))
}
