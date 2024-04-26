//
//  RangeSliderScreen.swift
//  SwiftUIShowcase
//
//  Created by 𝕶𝖎𝖑𝖎𝖌 on 4/26/24.
//

import SwiftUI

struct RangeSliderScreen: View {
  @State private var selection: ClosedRange<CGFloat> = 50...70

  var body: some View {
    VStack(spacing: 20) {
      Text("""
        RangeSliderView(
          range: 30...100,
          selection: 50...70,
          minimumDistance: 10
        )
        """
      )
      .font(.title3.monospaced())
      .padding()
      .background(Color(uiColor: .secondarySystemBackground)
        .clipShape(RoundedRectangle(cornerRadius: 20)))
      .padding(.top, 20)

      RangeSliderView(range: 30...100,
                      selection: $selection,
                      minimumDistance: 10)
        .padding()

      Spacer()
    }
    .navigationTitle("Range Slider")
    .toolbar {
      Link(destination: URL(string: "https://www.youtube.com/watch?v=L_8BqLus4NA")!, label: {
        Label("Range Slider", systemImage: "c.circle")
          .labelStyle(.iconOnly)
      })
    }
  }
}

#Preview {
  RangeSliderScreen()
}
