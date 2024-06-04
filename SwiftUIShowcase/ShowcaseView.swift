//
//  ShowcaseView.swift
//  SwiftUIShowcase
//
//  Created by 𝕶𝖎𝖑𝖎𝖌 on 3/21/24.
//

import SwiftUI

struct ShowcaseView: View {
  var body: some View {
    NavigationStack {
      List {
        NavigationLink { NeumorphicView()              } label: { Text("Neumorphism") }
        NavigationLink { WeatherView()                 } label: { Text("WeatherCard") }
        NavigationLink { WheelPickerScreen()           } label: { Text("Horizontal Wheel Picker") }
        NavigationLink { SegmentedControlScreen()      } label: { Text("Elastic Segmented Control") }
        NavigationLink { TextCharacterFlipScreen()     } label: { Text("3D Text Character Flip") }
        NavigationLink { DVDScreensaverScreen()        } label: { Text("DVD Screensaver") }
        NavigationLink { AnimatedPageIndicatorScreen() } label: { Text("Animated Page Indicator") }
        NavigationLink { StackedCardsScreen()          } label: { Text("Stacked Cards") }
        NavigationLink { LoopingScrollViewScreen()     } label: { Text("Looping Scrollview") }
        NavigationLink { FluorescenceScreen()          } label: { Text("Fluorescence") }
        NavigationLink { FetchMoreScreen()             } label: { Text("JSON Parsing With Pagination") }
        NavigationLink { RangeSliderScreen()           } label: { Text("Range Slider") }
        NavigationLink { HeroAnimationScreen()         } label: { Text("Hero Effect") }
        NavigationLink { SlideToUnlockScreen()         } label: { Text("Slide To Unlock") }
        NavigationLink { HueRotationEffectScreen()     } label: { Text("Hue Rotation Effect") }
        NavigationLink { CustomViewTransitionScreen()  } label: { Text("Custom View Transition") }
        NavigationLink { FlipClockScreen()             } label: { Text("Flip Clock") }
        NavigationLink { HackerTextEffectScreen()      } label: { Text("Hacker Text Effect") }
        NavigationLink { WaveScreen()                  } label: { Text("Wave") }
      }
      .navigationTitle("SwiftUI Showcase")
    }
  }
}

#Preview {
  ShowcaseView()
}
