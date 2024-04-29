//
//  SwiftUIShowcaseApp.swift
//  SwiftUIShowcase
//
//  Created by 𝕶𝖎𝖑𝖎𝖌 on 3/21/24.
//

import SwiftUI

@main
struct SwiftUIShowcaseApp: App {
  var body: some Scene {
    WindowGroup {
      HeroWrapper {
        ShowcaseView()
      }
    }
  }
}
