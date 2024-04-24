//
//  PhotoCardView.swift
//  SwiftUIShowcase
//
//  Created by 𝕶𝖎𝖑𝖎𝖌 on 4/24/24.
//

import Kingfisher
import SwiftUI

struct PhotoCardView: View {
  var photo: Photo

  var body: some View {
    VStack(alignment: .center, spacing: 10) {
      GeometryReader {
        let size = $0.size

        KFImage(photo.imageURL)
          .resizable()
          .placeholder {
            ProgressView()
              .frame(width: size.width, height: size.height)
          }
          .scaledToFill()
          .frame(width: size.width, height: size.height)
          .clipShape(.rect(cornerRadius: 10))
      }
      .frame(height: 120)

      Text(photo.author)
        .font(.caption)
        .foregroundStyle(.gray)
        .lineLimit(1)
    }
  }
}
