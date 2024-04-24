//
//  NeumorphicAsyncButton.swift
//  SwiftUIShowcase
//
//  Created by 𝕶𝖎𝖑𝖎𝖌 on 3/23/24.
//

import SwiftUI

struct NeumorphicAsyncButton: View {
  var text: String
  var icon: String

  var action: () async throws -> String

  @State private var isPerformingTask = false
  @State private var isCompleted = false

  var body: some View {
    Button(
      action: {
        withAnimation(.spring(response: 0.4, dampingFraction: 0.5)) {
          isPerformingTask = true
        }
        Task {
          let state = try await action()
          withAnimation(.spring(response: 0.4, dampingFraction: 0.5)) {
            isPerformingTask = false
            isCompleted = true
          }
          print(state)

          // Go back to the inactive state of the button
          DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.5)) {
              isCompleted = false
            }
          }
        }
      },
      label: {
        HStack(spacing: 20) {
          // Appear only on inactive state
          if !isPerformingTask && !isCompleted {
            Text(text.uppercased())
              .fontWeight(.semibold)
              .foregroundColor(.gray)
          }
          // icon
          Image(systemName: icon)
            .resizable()
            .scaledToFit()
            .frame(width: 20)
          // Appear only on isPerforming state
          if isPerformingTask && !isCompleted {
            DotProgressView()
          }
        }
        .foregroundColor(isCompleted ? Color.pink : Color.gray)
        .opacity(isPerformingTask ? 0.5 : 1)
        .padding(.horizontal, isCompleted && !isPerformingTask ? 0 : 15)
      }
    )
    .buttonStyle(NeumorphicButtonStyle(shape: RoundedRectangle(cornerRadius: 20)))
    .disabled(isPerformingTask || isCompleted)
  }
}

#Preview {
  NeumorphicAsyncButton(text: "TAP ME", icon: "heart.fill") {
    try await Task.sleep(for: .seconds(3))
    return "done"
  }
}
