//
//  MusicInformationView.swift
//  iTunesSearchAPIExercise
//
//  Created by WillyChen on 2023/5/8.
//

import UIKit
import SDWebImage

class MusicInformationView: NibView {
    @IBOutlet weak var albumCoverImageView: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    
    // MARK: - override
    override func afterSetUp() {
        let textColor: UIColor = .white
        trackNameLabel.textColor = textColor
        artistNameLabel.textColor = textColor
        trackNameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        artistNameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        view.backgroundColor = .clear
        changeUI(musicDM: nil)
    }
    // MARK: - private
    private func changeUI(musicDM: MusicDM?) {
        if let musicInfo = musicDM {
            albumCoverImageView.sd_setImage(with: musicInfo.artworkUrl100)
            trackNameLabel.text = musicInfo.trackName
            artistNameLabel.text = musicInfo.artistName
            
        } else {
            albumCoverImageView.sd_setImage(with: nil)
            trackNameLabel.text = "null"
            artistNameLabel.text = "null"
        }
    }
    // MARK: - internal
    func updateMusicInfo(musicDM: MusicDM?) {
        changeUI(musicDM: musicDM)
    }
}
