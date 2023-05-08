//
//  PlayerView.swift
//  iTunesSearchAPIExercise
//
//  Created by WillyChen on 2023/5/8.
//

import UIKit

protocol PlayerViewDelegate: AnyObject {
    func clickPlayButton(state: PlayerState)
}

class PlayerView: NibView {
    @IBOutlet weak var playButton: UIButton!
    
    weak var delegate: PlayerViewDelegate?
    private var musicDM: MusicDM?
    private var playerState: PlayerState = .stop {
        didSet {
            changeUI()
        }
    }
    
    // MARK: - override
    override func afterSetUp() {
        view.backgroundColor = .clear
        playButton.imageView?.contentMode = .scaleAspectFill
        playButton.backgroundColor = .white
        playButton.layer.cornerRadius = playButton.frame.height / 2
        playButton.layer.masksToBounds = true
        changeUI()
    }
    // MARK: - internal
    func updateState(playerState: PlayerState, musicDM: MusicDM?) {
        self.musicDM = musicDM
        self.playerState = playerState
    }
    // MARK: - private
    private func changeBtnState() {
        guard musicDM != nil else {
            return
        }
        playerState = playerState == .play ? .stop : .play
    }
    
    private func changeUI() {
        guard musicDM != nil else {
            emptyUI()
            return
        }
        if playerState == .play {
            playButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            playButton.setImage(UIImage(systemName: "pause.fill")?.maskWithColor(color: .black), for: .normal)
        } else {
            emptyUI()
        }
        
        func emptyUI() {
            playButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 0)
            playButton.setImage(UIImage(systemName: "play.fill")?.maskWithColor(color: .black), for: .normal)
        }
    }
    // MARK: - IBAction
    @IBAction func playBtnAction(_ sender: Any) {
        changeBtnState()
        delegate?.clickPlayButton(state: playerState)
    }
}
