//
//  PlayerManager.swift
//  iTunesSearchAPIExercise
//
//  Created by WillyChen on 2023/5/8.
//

import UIKit
import AVKit
import MediaPlayer

protocol PlayerManagerDelegate: AnyObject {
    func playerManagerStateUpdate(state: PlayerState)
}

class PlayerManager: NSObject {
    static let shared = PlayerManager()
    weak var delegate: PlayerManagerDelegate?
    private let player = AVPlayer()
    private let session = AVAudioSession.sharedInstance()
    // MARK: - internal
    func setUpPlayer(with url: URL) {
        let asset = AVURLAsset(url: url)
        let playerItem = AVPlayerItem(asset: asset)
        self.player.replaceCurrentItem(with: playerItem)
        self.player.allowsExternalPlayback = true
        self.player.usesExternalPlaybackWhileExternalScreenIsActive = true
        do {
            try session.setCategory(.playback, mode: .default, options: [.mixWithOthers, .allowBluetooth])
            try session.setActive(true)
        } catch let error {
            print("設置AVAudioSession時發生錯誤: \(error.localizedDescription)")
        }
    }
    
    func startPlayer() {
        player.play()
        NotificationCenter.default.addObserver(self, selector: #selector(self.playerNotification(notification:)), name: .AVPlayerItemDidPlayToEndTime, object: nil)
        
    }
    
    func stopPlayer() {
        player.pause()
        NotificationCenter.default.removeObserver(self)
    }
    
    func cleanPlayer()  {
        stopPlayer()
        self.player.replaceCurrentItem(with: nil)
    }
    
    @objc func playerNotification(notification: Notification) {
        switch notification.name {
        case .AVPlayerItemDidPlayToEndTime:
            stopPlayer()
            self.player.seek(to: CMTime.zero)
            delegate?.playerManagerStateUpdate(state: .stop)
        default:
            break
        }
    }
}
