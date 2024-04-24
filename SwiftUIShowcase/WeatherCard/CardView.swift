//
//  CardView.swift
//  Effects
//
//  Created by 𝕶𝖎𝖑𝖎𝖌 on 1/25/24.
//

import SwiftUI

struct CardView: View {
  let index: Int
  let coordinateSpace: CoordinateSpace

  private let headerHeight: CGFloat = 20

  @State private var offset: CGFloat = 0
  @State private var cellHeight: CGFloat = 0

  private var maxOffset: CGFloat {
    cellHeight - headerHeight - 16
  }

  var body: some View {
    ZStack {
      VStack(alignment: .leading, spacing: 0) {
        HeaderView()
          .frame(height: headerHeight)
          .padding(.bottom, 4)
          .offset(y: offset < 0 ? min(-offset, maxOffset) : 0)
        VStack(alignment: .leading) {
          Text("\(index + 1) - Title")
            .font(.system(size: 16))
            .bold()
            .padding(.bottom, 2)
          Text("This is description text...")
            .font(.system(size: 13))
        }
        .clipShape(.rect().offset(y: offset < 0 ? -offset : 0))
      }
      .padding(EdgeInsets(top: 8, leading: 12, bottom: 12, trailing: 12))
      .background(Material.ultraThin)
      .clipShape(.rect(cornerSize: .init(width: 8, height: 8), style: .continuous))
      .offset(y: offset < -maxOffset ? (-offset - maxOffset) : 0)
      .opacity(offset < -maxOffset ? (1 - (-offset - maxOffset) / 22.0) : 1)
    }
    .background(GeometryReader { reader in
      Color.clear
        .onChange(of: reader.frame(in: coordinateSpace)) { _, newValue in
          offset = newValue.minY
        }
        .onAppear {
          let frame = reader.frame(in: coordinateSpace)
          offset = frame.minY
          cellHeight = frame.height
        }
    })
  }
}
