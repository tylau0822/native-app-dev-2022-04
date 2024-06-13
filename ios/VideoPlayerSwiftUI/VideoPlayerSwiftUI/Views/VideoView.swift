//
//  VideoPlayerView.swift
//  VideoPlayerSwiftUI
//
//  Created by LAU TSZ YING on 13/6/2024.
//

import SwiftUI
import AVKit
import MarkdownKit

struct VideoView: View {
    @ObservedObject var videoVM = VideoViewModel()
    @ObservedObject var playerVM = PlayerViewModel()
    @State var selectedIndex: Int = 0
    
    var body: some View {
        VStack {
            Text("Video Player")
                .font(.title2)
            
            if videoVM.videos.isEmpty {
                ProgressView("Loading")
            } else {
                ZStack {
                    VideoPlayer(player: self.playerVM.player)
                        .frame(height: 200)
                        .disabled(true)
                    
                    HStack(spacing: 20) {
                        Button {
                            selectedIndex = selectedIndex - 1
                            self.playerVM.loadVideo(from: self.videoVM.videos[selectedIndex].fullURL)
                        } label: {
                            Image("previous")
                                .frame(width: 60, height: 60)
                                .background(RoundedRectangle(
                                    cornerRadius: 50,
                                    style: .continuous)
                                    .fill(.white.opacity(selectedIndex == 0 ? 0.3 : 0.8))
                                )
                        }.disabled(selectedIndex == 0)
                        
                        Button {
                            self.playerVM.isPlaying ? self.playerVM.pauseVideo() : self.playerVM.playVideo()
                        } label: {
                            Image(self.playerVM.isPlaying ? "pause" : "play")
                                .frame(width: 80, height: 80)
                                .background(RoundedRectangle(
                                    cornerRadius: 50,
                                    style: .continuous)
                                    .fill(.white.opacity(0.8))
                                )
                        }
                        
                        Button {
                            selectedIndex = selectedIndex + 1
                            self.playerVM.loadVideo(from: self.videoVM.videos[selectedIndex].fullURL)
                        } label: {
                            Image("next")
                                .frame(width: 60, height: 60)
                                .background(RoundedRectangle(
                                    cornerRadius: 50,
                                    style: .continuous)
                                    .fill(.white.opacity(selectedIndex >= videoVM.videos.count-1 ? 0.3 : 0.8))
                                )
                        }.disabled(selectedIndex >= videoVM.videos.count-1)
                    }
                }
                
                Spacer()
                
                ScrollView {
                    VStack(alignment: .leading) {
                        Text(self.videoVM.videos[selectedIndex].title)
                            .font(.title3)
                            .bold()
                        
                        Text(self.videoVM.videos[selectedIndex].author.name)
                            .font(.subheadline)
                        
                        Text("\(MarkdownParser().parse(self.videoVM.videos[selectedIndex].description))")
                            .padding([.top])
                    }.padding(10)
                    
                }
            }
        }
        .onAppear() {
            Task {
                await videoVM.fetchVideos()
                selectedIndex = 0
                if !videoVM.videos.isEmpty {
                    playerVM.loadVideo(from: videoVM.videos[selectedIndex].fullURL)
                }
            }
        }
    }
}

struct VideoView_Previews: PreviewProvider {
    static var previews: some View {
        VideoView()
    }
}
