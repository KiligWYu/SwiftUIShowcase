//
//  WheelPickerScreen.swift
//  SwiftUIShowcase
//
//  Created by 𝕶𝖎𝖑𝖎𝖌 on 3/23/24.
//

import SwiftUI

struct WheelPickerScreen: View {
  @State private var config = WheelPickerView.Config(count: 30)
  @State private var value: CGFloat = 0

  var body: some View {
    VStack(spacing: 50) {
      titleView

      WheelPickerView(config: config, value: $value)
        .frame(height: 60)

      configView
    }
    .navigationTitle("Wheel Picker")
    .toolbar {
      Link(destination: URL(string: "https://www.youtube.com/watch?v=v5T_0AQkQHE")!) {
        Label("Copyright", systemImage: "c.circle")
          .labelStyle(.iconOnly)
      }
    }
  }

  @MainActor
  @ViewBuilder
  private var titleView: some View {
    HStack(alignment: .lastTextBaseline, spacing: 5) {
      Text(verbatim: "\(value)")
        .font(.largeTitle.bold())
        .contentTransition(.numericText(value: value))
        .animation(.snappy, value: value)

      Text("lbs")
        .font(.title2)
        .fontWeight(.semibold)
        .textScale(.secondary)
        .foregroundStyle(.gray)
    }
    .padding(.top, 50)
  }

  @MainActor
  @ViewBuilder
  private var configView: some View {
    Form {
      countSection
      stepsSection
      multiplierSection
      spacingSection
    }
  }

  @MainActor
  @ViewBuilder
  private var countSection: some View {
    Section {
      Picker(selection: $config.count, content: {
        ForEach([10, 20, 30], id: \.self) { value in
          Text("\(value)")
            .tag(value)
        }
      }, label: {
        Text("Count")
      })
      .pickerStyle(SegmentedPickerStyle())
    } header: {
      Text("Count")
    }
  }

  @MainActor
  @ViewBuilder
  private var stepsSection: some View {
    Section {
      Picker(selection: $config.steps, content: {
        ForEach([5, 10], id: \.self) { value in
          Text("\(value)")
            .tag(value)
        }
      }, label: {
        Text("Steps")
      })
      .pickerStyle(SegmentedPickerStyle())
    } header: {
      Text("Steps")
    }
  }

  @MainActor
  @ViewBuilder
  private var multiplierSection: some View {
    Section {
      Picker(selection: $config.multiplier, content: {
        ForEach([1, 10], id: \.self) { value in
          Text("\(value)")
            .tag(value)
        }
      }, label: {
        Text("Multiplier")
      })
      .pickerStyle(SegmentedPickerStyle())
    } header: {
      Text("Multiplier")
    }
  }

  @MainActor
  @ViewBuilder
  private var spacingSection: some View {
    Section {
      Slider(value: $config.spacing, in: 1 ... 10, step: 1)
        .onChange(of: config.spacing) { _, _ in
          value = value
        }
    } header: {
      Text("Spacing")
    }
  }
}

#Preview {
  WheelPickerScreen()
}
