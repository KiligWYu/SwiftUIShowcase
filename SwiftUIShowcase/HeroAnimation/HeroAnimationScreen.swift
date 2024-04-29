//
//  HeroAnimationScreen.swift
//  SwiftUIShowcase
//
//  Created by 𝕶𝖎𝖑𝖎𝖌 on 4/28/24.
//

import SwiftUI

struct Item: Identifiable {
  var id: UUID = .init()
  var title: String
  var color: Color
  var symbol: String
}

// MARK: -

var items: [Item] = [
  .init(title: "Book Icon", color: .red, symbol: "book.fill"),
  .init(title: "Stack Icon", color: .blue, symbol: "square.stack.3d.up"),
  .init(title: "Rectangle Icon", color: .orange, symbol: "rectangle.portrait")
]

// MARK: -

struct HeroAnimationScreen: View {
  var body: some View {
    List {
      ForEach(items) { item in
        HeroCardView(item: item)
      }
    }
    .navigationTitle("Hero Effect")
    .toolbar {
      Link(destination: URL(string: "https://www.youtube.com/watch?v=d0y_f9kCSDk")!) {
        Label("Progress based hero animation", systemImage: "c.circle")
          .labelStyle(.iconOnly)
      }
    }
  }
}

// MARK: -

struct HeroCardView: View {
  var item: Item
  @State private var expandSheet: Bool = false

  var body: some View {
    HStack(spacing: 12) {
      SourceView(id: item.id.uuidString) {
        imageView()
      }

      Text(item.title)

      Spacer(minLength: 0)
    }
    .contentShape(.rect)
    .onTapGesture {
      expandSheet.toggle()
    }
    .sheet(isPresented: $expandSheet, content: {
      HStack {
        Button {
          expandSheet.toggle()
        } label: {
          Image(systemName: "xmark")
            .font(.title2)
            .contentShape(.rect)
        }

        Spacer(minLength: 0)

        DestinationView(id: item.id.uuidString) {
          imageView()
        }
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
      .padding()
      .interactiveDismissDisabled()
    })
    .heroLayer(id: item.id.uuidString, animate: $expandSheet) {
      imageView()
    } completion: { _ in }
  }

  @ViewBuilder
  func imageView() -> some View {
    Image(systemName: item.symbol)
      .font(.title2)
      .foregroundStyle(.white)
      .frame(width: 40, height: 40)
      .background(item.color.gradient, in: .circle)
  }
}
