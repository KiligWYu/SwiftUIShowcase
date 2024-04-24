//
//  FetchMoreScreen.swift
//  SwiftUIShowcase
//
//  Created by 𝕶𝖎𝖑𝖎𝖌 on 4/24/24.
//

import SwiftUI

struct FetchMoreScreen: View {
  @State private var photos = [Photo]()
  @State private var page = 1
  @State private var maxPage = 5
  @State private var lastFetchedPage = 1
  @State private var isLoading = false
  @State private var activePhotoID: String?
  @State private var lastPhotoID: String?

  var body: some View {
    ScrollView(.vertical) {
      LazyVGrid(columns: Array(repeating: GridItem(spacing: 10), count: 3), spacing: 10) {
        ForEach(photos) { photo in
          PhotoCardView(photo: photo)
        }
      }
      .overlay(alignment: .bottom) {
        if isLoading {
          ProgressView()
            .offset(y: 30)
        }
      }
      .padding(15)
      .padding(.bottom, 15)
      .scrollTargetLayout()
    }
    /*
     For some reason, .scrollPosition is causing stuttering on physical devices,
     this may be a bug, to solve this simply replace the line to the next line
     */
//    .scrollPosition(id: $activePhotoID, anchor: .bottomTrailing)
    .scrollPosition(
      id: Binding<String?>(get: { "" },
                           set: { newValue in activePhotoID = newValue }),
      anchor: .bottomTrailing)
    .onChange(of: activePhotoID) { _, newValue in
      if newValue == lastPhotoID, !isLoading, page < maxPage {
        page += 1
        fetchPhotos()
      }
    }
    .onAppear {
      if photos.isEmpty { fetchPhotos() }
    }
    .navigationTitle("Pagination")
    .toolbar {
      Link(destination: URL(string: "https://www.youtube.com/watch?v=bhn3WanfkZI")!) {
        Label("JSON Parsing With Pagination", systemImage: "c.circle")
          .labelStyle(.iconOnly)
      }
    }
  }

  private func fetchPhotos() {
    Task {
      do {
        guard let url = URL(string: "https://picsum.photos/v2/list?page=\(page)") else { return }

        isLoading = true
        let data = try await URLSession.shared.data(from: url).0
        let photos = try JSONDecoder().decode([Photo].self, from: data)

        await MainActor.run {
          if photos.isEmpty {
            page = lastFetchedPage
            maxPage = lastFetchedPage
          } else {
            self.photos.append(contentsOf: photos)
            lastPhotoID = photos.last?.id
            lastFetchedPage = page
          }

          isLoading = false
        }
      } catch {
        isLoading = false
        page = lastFetchedPage
        print(error)
      }
    }
  }
}

#Preview {
  FetchMoreScreen()
}
