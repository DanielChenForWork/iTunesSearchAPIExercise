//
//  MusicDataProvider.swift
//  iTunesSearchAPIExercise
//
//  Created by WillyChen on 2023/5/8.
//

import Foundation
import Combine

class MusicDataProvider {
    static let shared = MusicDataProvider()
    private var prevSearchStr: String?
    
    func fetchMusic(searchStr: String?) -> AnyPublisher<MusicSearchResponse, ApiError> {
        guard prevSearchStr != searchStr else {
            return Fail(error: ApiError.sameURL)
                .eraseToAnyPublisher()
        }
        guard let urlStr = "https://itunes.apple.com/search?term=\(searchStr ?? "")&media=music".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) , let url = URL(string: urlStr)  else {
            return Fail(error: ApiError.invalidURL)
                .eraseToAnyPublisher()
        }
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let urlRequest = URLRequest(url: url)
        
        prevSearchStr = searchStr
        
        return session.dataTaskPublisher(for: urlRequest)
            .tryMap { response in
                guard
                    let httpURLResponse = response.response as? HTTPURLResponse,
                    httpURLResponse.statusCode == 200
                else {
                    throw ApiError.statusCode
                }
                return response.data
            }
            .decode(type: MusicSearchResponse.self, decoder: JSONDecoder())
            .mapError { ApiError.map($0) }
            .eraseToAnyPublisher()
    }
}
