//
//  HackerTextView.swift
//  SwiftUIShowcase
//
//  Created by 𝕶𝖎𝖑𝖎𝖌 on 5/30/24.
//

import SwiftUI

struct HackerTextView: View {
  var text: String
  var trigger: Bool
  var transition = ContentTransition.interpolate
  var duration: CGFloat = 1.0
  var speed: CGFloat = 0.1
  @State private var animatedText = ""
  @State private var animationID = UUID().uuidString
  private let characters: [Character] = {
    let string = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890-=!@#$%^&*()_+[]|;':\",./<>?"
    return Array(string)
  }()

  var body: some View {
    Text(animatedText)
      .fontDesign(.monospaced)
      .truncationMode(.tail)
      .contentTransition(transition)
      .animation(.easeInOut(duration: 0.15), value: animatedText)
      .onAppear {
        guard animatedText.isEmpty else { return }
        setRandomCharacters()
        animateText()
      }
      .onChange(of: trigger) { _, _ in
        animateText()
      }
      .onChange(of: text) { _, _ in
        animatedText = text
        animationID = UUID().uuidString
        setRandomCharacters()
        animateText()
      }
  }

  private func animateText() {
    let currentID = animationID
    for index in text.indices {
      let delay = CGFloat.random(in: 0...duration)
      var timerDuration: CGFloat = 0
      let timer = Timer.scheduledTimer(withTimeInterval: speed, repeats: true) { _ in
        MainActor.assumeIsolated {
          guard currentID == animationID else { return }

          timerDuration += speed
          if timerDuration >= delay {
            if text.indices.contains(index) {
              let actualCharacter = text[index]
              replaceCharacter(at: index, character: actualCharacter)
            }
          } else {
            guard let randomCharacter = characters.randomElement() else { return }
            replaceCharacter(at: index, character: randomCharacter)
          }
        }
      }

      timer.fire()

      DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
        timer.invalidate()
      }
    }
  }

  private func setRandomCharacters() {
    animatedText = text
    for index in animatedText.indices {
      guard let randomCharacter = characters.randomElement() else { return }
      replaceCharacter(at: index, character: randomCharacter)
    }
  }

  private func replaceCharacter(at index: String.Index, character: Character) {
    guard animatedText.indices.contains(index) else { return }
    let indexCharacter = String(animatedText[index])
    guard !indexCharacter.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
    animatedText.replaceSubrange(index...index, with: String(character))
  }
}

#Preview {
  HackerTextEffectScreen()
}
