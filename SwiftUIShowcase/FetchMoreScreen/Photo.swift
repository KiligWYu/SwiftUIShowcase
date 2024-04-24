//
//  Photo.swift
//  SwiftUIShowcase
//
//  Created by 𝕶𝖎𝖑𝖎𝖌 on 4/24/24.
//

import Foundation

struct Photo: Identifiable, Codable, Hashable {
  var id: String
  var author: String
  var url: String
  private var downloadURLString: String

  enum CodingKeys: String, CodingKey {
    case id, author, url, downloadURLString = "download_url"
  }

  var imageURL: URL? {
    URL(string: "https://picsum.photos/id/\(id)/256/256.jpg")
  }
}
