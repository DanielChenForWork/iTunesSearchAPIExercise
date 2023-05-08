//
//  PlayerManager.swift
//  iTunesSearchAPIExercise
//
//  Created by WillyChen on 2023/5/8.
//

import UIKit
import AVKit
import MediaPlayer

class PlayerManager: NSObject {
    static let shared = PlayerManager()
    private let player = AVPlayer()
    // MARK: - internal
    func setUpPlayer(with url: URL) {
        let asset = AVURLAsset(url: url)
        let playerItem = AVPlayerItem(asset: asset)
        DispatchQueue.main.async {
            self.player.replaceCurrentItem(with: playerItem)
            self.player.allowsExternalPlayback = true
            self.player.usesExternalPlaybackWhileExternalScreenIsActive = true
        }
    }
}
