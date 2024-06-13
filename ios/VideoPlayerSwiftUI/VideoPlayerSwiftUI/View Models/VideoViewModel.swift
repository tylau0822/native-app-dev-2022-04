//
//  VideoViewModel.swift
//  VideoPlayerSwiftUI
//
//  Created by LAU TSZ YING on 13/6/2024.
//

import Foundation

class VideoViewModel: ObservableObject {
    
    @Published var videos: [Video] = []
    
    func fetchVideos() async {
        do {
            if let videos = try await NetworkManager().fetchVideos() {
                DispatchQueue.main.async {
                    self.videos = videos
                }
            }
        } catch {
            print(error)
        }
    }
}
