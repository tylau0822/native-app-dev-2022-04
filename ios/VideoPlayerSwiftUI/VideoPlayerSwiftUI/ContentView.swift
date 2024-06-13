//
//  ContentView.swift
//  VideoPlayerSwiftUI
//
//  Created by Michael Gauthier on 2021-01-06.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var videoVM = VideoViewModel()
    
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onAppear() {
                Task {
                    await videoVM.fetchVideos()
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
