//
//  NetworkManager.swift
//  VideoPlayerSwiftUI
//
//  Created by LAU TSZ YING on 13/6/2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
}

class NetworkManager {
    
    func fetchVideos() async throws -> [Video]? {
        let urlString = "http://localhost:4000/videos"
        
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        let videos = try JSONDecoder().decode([Video].self, from: data)
        return videos
    }
}
