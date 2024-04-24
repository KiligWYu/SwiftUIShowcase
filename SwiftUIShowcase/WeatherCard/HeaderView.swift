//
//  HeaderView.swift
//  Effects
//
//  Created by 𝕶𝖎𝖑𝖎𝖌 on 1/25/24.
//

import SwiftUI

struct HeaderView: View {
  var body: some View {
    HStack {
      Image(systemName: "info.circle.fill")
        .resizable()
        .frame(width: 12, height: 12)
      Text("Section Header")
        .font(.system(size: 13))
      Spacer()
    }
  }
}

#Preview {
  HeaderView()
}
