//
//  HomePageVM.swift
//  iTunesSearchAPIExercise
//
//  Created by WillyChen on 2023/5/8.
//

import UIKit
import Combine

protocol HomePageVMDelegate: AnyObject {
    func dataDidUpdate(status: Bool)
    func playerDataDidUpdate(playerState: PlayerState, selectedMusic: MusicDM?)
}

class HomePageVM {
    weak var delegate: HomePageVMDelegate?
    private var musicDMs: [MusicDM]?
    private var subscriptions: Set<AnyCancellable> = []
    private var playerStatus: PlayerState = .stop {
        didSet {
            if playerStatus == .play {
                playerManager.startPlayer()
            } else {
                playerManager.stopPlayer()
            }
        }
    }
    private var selectedMusic: MusicDM?
    private let playerManager = PlayerManager.shared
    
    var searchResultCount: Int {
        return musicDMs?.count ?? 0
    }
    
    // MARK: - init
    init(musicDMs: [MusicDM]?) {
        self.musicDMs = musicDMs
        playerManager.delegate = self
    }
    // MARK: - internal
    func getCellData(indexPath: IndexPath) -> MusicDM? {
        guard indexPath.section == 0, let musicList = musicDMs , musicList.indices.contains(indexPath.row) else {
            return nil
        }
        return musicList[indexPath.row]
    }
    
    func clean() {
        subscriptions.forEach { $0.cancel() }
        playerManager.cleanPlayer()
    }
    
    func playerStateUpdate(state: PlayerState) {
        playerStatus = state
    }
    
    func selectMusic(indexPath: IndexPath) {
        guard indexPath.section == 0, let musicList = musicDMs , musicList.indices.contains(indexPath.row) else {
            return
        }
        selectedMusic = musicList[indexPath.row]
        if let url =  selectedMusic?.previewUrl {
            playerManager.setUpPlayer(with: url)
            playerStatus = .play
        }
        delegate?.playerDataDidUpdate(playerState: playerStatus, selectedMusic: selectedMusic)
    }
    
    func startGetData(searchText: String?) {
        MusicDataProvider.shared.fetchMusic(searchStr: searchText)
            .receive(on: DispatchQueue.global())
            .sink(receiveCompletion: { [unowned self] completion in
                switch completion {
                case .finished: break
                case .failure(_):
                    self.musicDMs = nil
                    delegate?.dataDidUpdate(status: false)
                }
            }, receiveValue: { [unowned self] musicSearchResponse in
                self.musicDMs = musicSearchResponse.results
                let status = (self.musicDMs ?? []).isEmpty ? false : true
                delegate?.dataDidUpdate(status: status)
            })
            .store(in: &subscriptions)
    }
}
// MARK: - PlayerManagerDelegate
extension HomePageVM: PlayerManagerDelegate {
    func playerManagerStateUpdate(state: PlayerState) {
        self.playerStatus = state
        delegate?.playerDataDidUpdate(playerState: playerStatus, selectedMusic: selectedMusic)
    }
}
