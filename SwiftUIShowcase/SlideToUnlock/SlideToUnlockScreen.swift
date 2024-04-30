//
//  SlideToUnlockScreen.swift
//  SwiftUIShowcase
//
//  Created by 𝕶𝖎𝖑𝖎𝖌 on 4/30/24.
//

import SwiftUI

struct SlideToUnlockScreen: View {
  var body: some View {
    SlideToActionButton(
      leadingView: Image(systemName: "lock"),
      trailingView: Image(systemName: "lock.open"),
      actionFunction: sleep2s
    )
    .padding()
    .navigationTitle("Slide To Unlock")
    .toolbar {
      Link(destination:
        URL(string: "https://blog.stackademic.com/swiftui-slide-to-unlock-button-f2b1bcedea83")!,
        label: {
          Label("SwiftUI: Slide To Unlock Button", systemImage: "c.circle")
        })
    }
  }

  private func sleep2s() async {
    sleep(2)
  }
}

#Preview {
  SlideToUnlockScreen()
}

// MARK: -

struct BackgroundView: View {
  var body: some View {
    RoundedRectangle(cornerRadius: 16)
      .fill(Color.red.opacity(0.4))
      .overlay(
        HStack {
          Image(systemName: "chevron.right.2")
          Image(systemName: "chevron.right.2")
        }
        .font(.system(size: 16, weight: .regular, design: .rounded))
        .foregroundStyle(Color.white.opacity(0.6)),

        alignment: .center
      )
  }
}

// MARK: -

enum ActionState {
  case initial
  case loading
  case finish
}

// MARK: -

struct DraggableView<LeadingView: View, TrailingView: View>: View {
  let leadingView: LeadingView
  let trailingView: TrailingView
  let maxDraggableWidth: CGFloat
  let actionFunction: () async -> Void

  private let minWidth: CGFloat = 50
  private let imagePadding: CGFloat = 4
  @State private var width: CGFloat = 50
  @State var actionState: ActionState = .initial

  var body: some View {
    let opacity: Double = (width / maxDraggableWidth)
    RoundedRectangle(cornerRadius: 16)
      .fill(Color.red.opacity(opacity))
      .frame(width: width)
      .overlay(
        Button(action: {}, label: {
          switch actionState {
          case .initial:
            leadingView
          case .loading:
            ProgressView()
              .progressViewStyle(CircularProgressViewStyle(tint: Color.red))
          case .finish:
            trailingView
          }
        })
        .buttonStyle(CustomButtonStyle())
        .disabled(actionState != .initial)
        .font(.system(size: 20, weight: .regular, design: .rounded))
        .foregroundStyle(Color.red)
        .frame(width: minWidth - 2 * imagePadding, height: minWidth - 2 * imagePadding)
        .background(
          RoundedRectangle(cornerRadius: 14)
            .stroke(Color.red, lineWidth: 4)
            .fill(.white)
        )
        .padding(.all, imagePadding),
        alignment: .trailing
      )
      .highPriorityGesture(
        DragGesture()
          .onChanged { value in
            guard actionState == .initial else { return }
            if value.translation.width > 0 {
              width = min(value.translation.width + minWidth, maxDraggableWidth)
            }
          }
          .onEnded { _ in
            guard actionState == .initial else { return }

            if width < maxDraggableWidth {
              width = minWidth
              return
            }

            withAnimation(.spring().delay(0.5)) {
              actionState = .loading
            }

            Task {
              await actionFunction()
              DispatchQueue.main.async {
                actionState = .finish
              }
            }
          }
      )
      .animation(.spring(response: 0.3, dampingFraction: 0.8, blendDuration: 0), value: width)
  }
}

// MARK: -

private struct CustomButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .scaleEffect(1)
      .opacity(configuration.isPressed ? 0.5 : 1)
      .animation(.default, value: configuration.isPressed)
  }
}

// MARK: -

struct SlideToActionButton<LeadingView: View, TrailingView: View>: View {
  let leadingView: LeadingView
  let trailingView: TrailingView
  let actionFunction: () async -> Void

  var body: some View {
    GeometryReader { geometry in
      ZStack(alignment: .leading) {
        BackgroundView()
        DraggableView(
          leadingView: leadingView,
          trailingView: trailingView,
          maxDraggableWidth: geometry.size.width,
          actionFunction: actionFunction
        )
      }
    }
    .frame(height: 50)
  }
}
