//
//  MusicTableViewCell.swift
//  iTunesSearchAPIExercise
//
//  Created by WillyChen on 2023/5/8.
//

import UIKit
import SDWebImage

class MusicTableViewCell: UITableViewCell {
    
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var albumCoverImageView: UIImageView!
    // MARK: - override
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        
        let textColor: UIColor = .black
        
        trackNameLabel.textColor = textColor
        trackNameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        trackNameLabel.text = "null"
        
        artistNameLabel.textColor = textColor
        artistNameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        artistNameLabel.text = "null"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        trackNameLabel.textColor = selected ? .white : .black
        artistNameLabel.textColor = selected ? .white : .black
    }
    // MARK: - internal
    func setUp(musicDM: MusicDM) {
        trackNameLabel.text = musicDM.trackName
        artistNameLabel.text = musicDM.artistName
        albumCoverImageView.sd_setImage(with: musicDM.artworkUrl100)
    }
}
