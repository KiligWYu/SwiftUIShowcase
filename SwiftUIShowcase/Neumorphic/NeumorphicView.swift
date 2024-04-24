//
//  NeumorphicView.swift
//  Effects
//
//  Created by 𝕶𝖎𝖑𝖎𝖌 on 1/24/24.
//

import SwiftUI

struct NeumorphicView: View {
  var body: some View {
    VStack(spacing: 50) {
      NeumorphicCardView()
        .padding(.top, 30)

      HStack {
        Spacer()
        homeButton
        Spacer()
        closeButton
        Spacer()
      }
      .foregroundStyle(.gray)

      HStack {
        Spacer()
        sendButton
        Spacer()
        favButton
        Spacer()
      }
      .foregroundStyle(.gray)

      NeumorphicAsyncButton(text: "TAP ME", icon: "heart.fill", action: action)

      Spacer()
    }
    .padding()
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.offWhite)
    .toolbar {
      Link(
        destination: URL(
          string: "https://bootcamp.uxdesign.cc/build-a-neumorphic-micro-interaction-for-a-swiftui-button-aa8c3c53047d"
        )!
      ) {
        Label("Copyright", systemImage: "c.circle")
          .labelStyle(.iconOnly)
      }
    }
  }

  @MainActor
  @ViewBuilder
  private var homeButton: some View {
    Button {} label: {
      Label("Home", systemImage: "house")
        .labelStyle(.iconOnly)
    }
    .controlSize(.large)
    .buttonStyle(
      NeumorphicButtonStyle(
        shape: RotatedShape(
          shape: RoundedRectangle(cornerRadius: 10),
          angle: .degrees(45)
        )
      )
    )
  }

  @MainActor
  @ViewBuilder
  private var closeButton: some View {
    Button {} label: {
      Text("Close")
    }
    .buttonStyle(NeumorphicButtonStyle(shape: RoundedRectangle(cornerRadius: 50)))
  }

  @MainActor
  @ViewBuilder
  private var sendButton: some View {
    Button {} label: {
      Label("Send", systemImage: "paperplane.fill")
        .labelStyle(.trailingIcon)
    }
    .buttonStyle(NeumorphicButtonStyle(shape: RoundedRectangle(cornerRadius: 10)))
  }

  @MainActor
  @ViewBuilder
  private var favButton: some View {
    Button {} label: {
      Label("Favourite", systemImage: "heart.fill")
        .labelStyle(.iconOnly)
    }
    .buttonStyle(NeumorphicButtonStyle(shape: Circle()))
  }

  private func action() async throws -> String {
    try await Task.sleep(for: .seconds(3))
    return "done"
  }
}

#Preview {
  NeumorphicView()
}

// MARK: -

struct NeumorphicCardView: View {
  var body: some View {
    VStack(spacing: 10) {
      Text("This is a Neumorphic Card")
        .font(.system(size: 25).bold())
      Text("A tutorial on creating neumorphic components and asynchronous button micro-interactions in SwiftUI.")
        .font(.system(size: 15))
        .multilineTextAlignment(.center)
    }
    .neumorphicStyle()
    .foregroundStyle(.black)
  }
}

// MARK: -

extension Color {
  static let offWhite = Color(
    red: 225 / 255,
    green: 225 / 255,
    blue: 235 / 255
  )
}
