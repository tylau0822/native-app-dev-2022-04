//
//  VideoViewModel.swift
//  VideoPlayerSwiftUI
//
//  Created by LAU TSZ YING on 13/6/2024.
//

import Foundation

class VideoViewModel: ObservableObject {
    
    @Published var videos: [Video] = []
    @Published var selectedIndex: Int = 0
    
    var title: String {
        return self.videos.isEmpty ? "" : self.videos[selectedIndex].title
    }
    
    var fullURL: String {
        return self.videos.isEmpty ? "" : self.videos[selectedIndex].fullURL
    }
    
    var description: String {
        return self.videos.isEmpty ? "" : self.videos[selectedIndex].description
    }
    
    var authorName: String {
        return self.videos.isEmpty ? "" : self.videos[selectedIndex].author.name
    }
    
    func fetchVideos() async {
        do {
            if let videos = try await NetworkManager().fetchVideos() {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
                dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                
                let sortedVideos = videos.sorted {
                    guard let date1 = dateFormatter.date(from: $0.publishedAt),
                          let date2 = dateFormatter.date(from: $1.publishedAt) else {
                        return false
                    }
                    return date1 < date2
                }
                
                DispatchQueue.main.async {
                    self.videos = sortedVideos
                }
            }
        } catch {
            print(error)
        }
    }
}
