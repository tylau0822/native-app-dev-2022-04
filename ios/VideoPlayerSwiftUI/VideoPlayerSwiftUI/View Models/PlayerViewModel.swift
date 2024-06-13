//
//  PlayerViewModel.swift
//  VideoPlayerSwiftUI
//
//  Created by LAU TSZ YING on 13/6/2024.
//

import Foundation
import AVKit

class PlayerViewModel: ObservableObject {
    
    @Published var player = AVPlayer()
    @Published var isPlaying = false
    
    func loadVideo(from url: String) {
        guard let videoURL = URL(string: url) else { return }
        let playerItem = AVPlayerItem(url: videoURL)
        player.replaceCurrentItem(with: playerItem)
        playVideo()
    }
    
    func playVideo() {
        player.play()
        isPlaying = true
    }
    
    func pauseVideo() {
        player.pause()
        isPlaying = false
    }
}
