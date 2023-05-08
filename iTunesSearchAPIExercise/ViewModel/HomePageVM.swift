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
}

class HomePageVM {
    weak var delegate: HomePageVMDelegate?
    private var musicDMs: [MusicDM]?
    private var subscriptions: Set<AnyCancellable> = []
    
    var searchResultCount: Int {
        return musicDMs?.count ?? 0
    }
    
    // MARK: - init
    init(musicDMs: [MusicDM]?) {
        self.musicDMs = musicDMs
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
