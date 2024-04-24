//
//  FluorescenceScreen.swift
//  SwiftUIShowcase
//
//  Created by 𝕶𝖎𝖑𝖎𝖌 on 4/4/24.
//

import SwiftUI
import UIKit

struct FluorescenceScreen: View {
  // swiftlint:disable:next force_cast
  private let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
  @State private var isProgressCompleted = false
  @State private var progress: CGFloat = 0
  @State private var timer: Timer?
  private let accentColor = Color.yellow

  @State private var contentOpacity = 1.0
  @State private var scaleIntoOneCard = false
  @State private var prepareToScaleIntoSixCard = false
  @State private var scaleIntoSixCard = false
  @State private var hideCard = false
  @Namespace private var shapeTransition
  @State private var code = ""
  @FocusState private var becomeFirstResponder: Bool
  @State private var shake = false
  @State private var blurDismiss = false

  var body: some View {
    Form {
      Section {
        HStack {
          Text("Version")
            .padding(.leading)
          Spacer()
          Text(version)
            .padding(.trailing)
        }
        .listRowInsets(.init())
        .opacity(contentOpacity)
        .frame(maxHeight: .infinity)
        .contentShape(Rectangle())
        .gesture(longGesture())
        .overlay {
          GeometryReader {
            let size = $0.size

            if !prepareToScaleIntoSixCard {
              RoundedRectangle(cornerRadius: scaleIntoOneCard ? 4 : 10.0, style: .continuous)
                .fill(accentColor)
                .frame(width: scaleIntoOneCard ? 20 : isProgressCompleted ? size.width : size.width * progress,
                       height: scaleIntoOneCard ? 26 : size.height)
                .shadow(color: accentColor.opacity(scaleIntoOneCard ? 0 : 0.3), radius: 80)
                .shadow(color: accentColor.opacity(scaleIntoOneCard ? 0 : 0.5), radius: 60)
                .shadow(color: accentColor.opacity(scaleIntoOneCard ? 0 : 0.6), radius: 20)
                .shadow(color: accentColor.opacity(0.7), radius: 8)
                .padding(.leading, scaleIntoOneCard ? (size.width - 20) / 2 : 0)
                .padding(.top, scaleIntoOneCard ? (size.height - 26) / 2 : 0)
            } else if !scaleIntoSixCard {
              ZStack {
                ForEach(0 ..< 6) { index in
                  RoundedRectangle(cornerRadius: 4, style: .continuous)
                    .fill(accentColor)
                    .shadow(color: index == 5 ? accentColor.opacity(0.7) : .clear, radius: 8)
                    .frame(width: 20, height: 26)
                    .matchedGeometryEffect(id: "card\(index)", in: shapeTransition)
                }
              }
              .frame(width: size.width)
              .padding(.top, (size.height - 26) / 2)
            } else if !blurDismiss {
              ZStack {
                HStack {
                  Spacer()
                  ForEach(0 ..< 6) { index in
                    RoundedRectangle(cornerRadius: 4, style: .continuous)
                      .fill(hideCard ? Color(uiColor: .systemBackground) : accentColor)
                      .stroke(Color(uiColor: .label).opacity(0.2), lineWidth: hideCard ? 1 : 0)
                      .shadow(color: hideCard ? Color.clear : accentColor.opacity(0.7), radius: 8)
                      .frame(width: 20, height: 26)
                      .matchedGeometryEffect(id: "card\(index)", in: shapeTransition)
                  }
                  Spacer()
                }

                TextField("", text: $code)
                  .kerning(20)
                  .font(.system(size: 13, weight: .bold, design: .monospaced))
                  .frame(width: 180)
                  .keyboardType(.asciiCapable)
                  .background(Color.clear)
                  .padding(.leading, 30)
                  .opacity(becomeFirstResponder ? 1 : 0)
                  .tint(accentColor)
                  .focused($becomeFirstResponder)
                  .offset(x: shake ? 4 : 0)
                  .onChange(of: code, inputCodeChanged)
              }
              .padding(.top, (size.height - 26) / 2)
              .id(blurDismiss)
              .transition(.blur)
            }
          }
          .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
      } header: {
        Text("Try to long press")
      }
      .onChange(of: isProgressCompleted) { _, newValue in
        if newValue { startSeriesAnimation() }
      }
    }
    .navigationTitle("Fluorescence")
    .toolbar {
      Link(destination:
        URL(string: "https://www.bmms.me/blog/silky-smooth-ios-progress-bar-interaction-explained")!
      ) {
        Label("超级干干干干货！丝滑的 iOS 进度条解锁交互到底是怎么制作的？", systemImage: "c.circle")
          .labelStyle(.iconOnly)
      }
    }
  }

  private func inputCodeChanged(_: String, newValue: String) {
    code = String(newValue.uppercased().prefix(6))
    if code.count == 6, code != "123456" {
      shake = true
      DispatchQueue.main.async {
        let feedbackGenerator = UINotificationFeedbackGenerator()
        feedbackGenerator.prepare()
        feedbackGenerator.notificationOccurred(.warning)

        withAnimation(.spring(response: 0.2, dampingFraction: 0.2, blendDuration: 0)) {
          self.shake = false
        }
      }
    } else if code == "123456" {
      DispatchQueue.main.async {
        withAnimation(.linear(duration: 0.5)) {
          blurDismiss = true
        } completion: {
          withAnimation { contentOpacity = 1 }
          restoreInitial()
        }
      }
    }
  }

  private func longGesture() -> some Gesture {
    LongPressGesture(minimumDuration: 0.5)
      .onEnded { _ in
        withAnimation {
          if !isProgressCompleted {
            startProgress()
          }
        }
      }
      .sequenced(before: DragGesture(minimumDistance: 0))
      .onEnded { _ in
        withAnimation {
          if !isProgressCompleted {
            resetProgress()
          }
        }
      }
  }

  private func startProgress() {
    timer?.invalidate()
    isProgressCompleted = false

    var increment = 0.0007
    let acceleration = 0.00007

    let feedbackGenerator = UIImpactFeedbackGenerator(style: .soft)
    feedbackGenerator.prepare()
    let vibrationThreshold: CGFloat = 0.01
    var lastVibrationProgress: CGFloat = 0

    timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { [self] timer in
      self.progress += increment
      increment += acceleration

      if self.progress >= lastVibrationProgress + vibrationThreshold {
        feedbackGenerator.impactOccurred()
        lastVibrationProgress = self.progress
      }

      if progress >= 1 {
        timer.invalidate()
        self.progress = 1
        self.isProgressCompleted = true
      }
    })
  }

  private func resetProgress() {
    timer?.invalidate()
    progress = 0
    isProgressCompleted = false
  }

  private func startSeriesAnimation() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
      withAnimation(.linear(duration: 0.25)) {
        contentOpacity = 0
        scaleIntoOneCard = true
      } completion: {
        prepareToScaleIntoSixCard = true
      }
      DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        withAnimation(.linear(duration: 0.25)) {
          scaleIntoSixCard = true
        }
      }
      DispatchQueue.main.asyncAfter(deadline: .now() + 1.75) {
        withAnimation(.linear(duration: 0.25)) {
          hideCard = true
        }
      }
      DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        becomeFirstResponder = true
      }
    }
  }

  private func restoreInitial() {
    resetProgress()
    code = ""
    hideCard = false
    scaleIntoOneCard = false
    scaleIntoSixCard = false
    blurDismiss = false
    becomeFirstResponder = false
    prepareToScaleIntoSixCard = false
  }
}

#Preview {
  FluorescenceScreen()
}
