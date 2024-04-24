//
//  Card.swift
//  SwiftUIShowcase
//
//  Created by 𝕶𝖎𝖑𝖎𝖌 on 3/29/24.
//

import SwiftUI

struct Card: Identifiable {
  var id = UUID()
  var color: Color
}

extension [Card] {
  func zIndex(_ card: Card) -> CGFloat {
    if let index = firstIndex(where: { $0.id == card.id }) {
      return CGFloat(count - index)
    }
    return .zero
  }
}
