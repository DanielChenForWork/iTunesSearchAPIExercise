//
//  MusicDM.swift
//  iTunesSearchAPIExercise
//
//  Created by WillyChen on 2023/5/8.
//

import UIKit

struct MusicSearchResponse: Decodable {
    let results: [MusicDM]
}

struct MusicDM: Decodable {
    let artistName: String?
    let artistViewUrl: URL?
    let trackName: String
    let previewUrl: URL
    let artworkUrl100: URL
}
