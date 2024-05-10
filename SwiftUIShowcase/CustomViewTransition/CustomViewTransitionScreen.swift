//
//  CustomViewTransitionScreen.swift
//  SwiftUIShowcase
//
//  Created by 𝕶𝖎𝖑𝖎𝖌 on 5/10/24.
//

import SwiftUI

struct CustomViewTransitionScreen: View {
  @Namespace var animation
  @State private var detailViewName: String?
  @State private var toolbarVisibility = Visibility.visible

  var body: some View {
    ZStack {
      if detailViewName == nil {
        RootView(animation: animation,
                 detailViewName: $detailViewName,
                 toolbarVisibility: $toolbarVisibility)
      } else {
        DetailView(animation: animation,
                   detailViewName: $detailViewName,
                   toolbarVisibility: $toolbarVisibility)
      }
    }
    .navigationTitle("Custom View Transition")
    .toolbar {
      // swiftlint:disable:next line_length
      Link(destination: URL(string: "https://blog.stackademic.com/swiftui-custom-view-transition-nav-with-matched-geometry-032552356fc5")!) {
        Label("SwiftUI: Custom View Transition(Navigation) With Matched Geometry", systemImage: "c.circle")
          .labelStyle(.iconOnly)
      }
    }
    .toolbar(toolbarVisibility, for: .navigationBar)
  }
}

#Preview {
  CustomViewTransitionScreen()
}

// MARK: -

struct RootView: View {
  var animation: Namespace.ID
  @Binding var detailViewName: String?
  @Binding var toolbarVisibility: Visibility

  var body: some View {
    VStack {
      Button {
        withAnimation {
          toolbarVisibility = .hidden
          detailViewName = "Detail 1"
        }
      } label: {
        Text("Detail 1")
          .matchedGeometryEffect(id: "title", in: animation)
          .font(.title3.bold())
          .foregroundStyle(Color.white)
      }
      .foregroundStyle(Color.white)
      .padding(8)
      .background(
        RoundedRectangle(cornerRadius: 8)
          .fill(Color.red)
      )

      Button {
        withAnimation {
          toolbarVisibility = .hidden
          detailViewName = "Detail 2"
        }
      } label: {
        Text("Detail 2")
          .font(.title3.bold())
          .foregroundStyle(Color.white)
      }
      .foregroundStyle(Color.white)
      .padding(8)
      .background(
        RoundedRectangle(cornerRadius: 8)
          .fill(Color.red)
          .matchedGeometryEffect(id: "background", in: animation)
      )
    }
    .frame(maxHeight: .infinity)
    .ignoresSafeArea()
  }
}

// MARK: -

struct DetailView: View {
  var animation: Namespace.ID
  @Binding var detailViewName: String?
  @Binding var toolbarVisibility: Visibility

  var body: some View {
    VStack {
      Text("\(detailViewName ?? "")")
        .matchedGeometryEffect(id: "title", in: animation)
        .font(.title3.bold())
        .foregroundStyle(Color.white)

      Spacer()
        .frame(height: 50)

      Button {
        withAnimation {
          toolbarVisibility = .visible
          detailViewName = nil
        }
      } label: {
        Text("Back")
          .font(.title3.bold())
          .foregroundStyle(Color.red)
      }
      .foregroundStyle(Color.red)
      .padding(8)
      .background(
        RoundedRectangle(cornerRadius: 8)
          .fill(Color.white)
      )
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    .padding(20)
    .background(
      Color(UIColor.red)
        .matchedGeometryEffect(id: "background", in: animation)
        .ignoresSafeArea()
    )
  }
}
