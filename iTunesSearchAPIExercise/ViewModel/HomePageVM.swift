//
//  HomePageVM.swift
//  iTunesSearchAPIExercise
//
//  Created by WillyChen on 2023/5/8.
//

import UIKit
import Combine

class HomePageVM {
    private var musicDMs: [MusicDM]?
    private var subscriptions: Set<AnyCancellable> = []
    
    var searchResultCount: Int {
        return musicDMs?.count ?? 0
    }
    
    // MARK: - init
    init(musicDMs: [MusicDM]?) {
        self.musicDMs = musicDMs
    }
    
    func startGetData(searchText: String?) {
        MusicDataProvider.shared.fetchMusic(searchStr: searchText)
            .receive(on: DispatchQueue.global())
            .sink(receiveCompletion: { [unowned self] completion in
                switch completion {
                case .finished: break
                case .failure(_):
                    self.musicDMs = nil
                }
            }, receiveValue: { [unowned self] musicSearchResponse in
                self.musicDMs = musicSearchResponse.results
                let status = (self.musicDMs ?? []).isEmpty ? false : true
            })
            .store(in: &subscriptions)
    }
}
