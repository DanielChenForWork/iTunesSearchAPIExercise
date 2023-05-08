//
//  ViewController.swift
//  iTunesSearchAPIExercise
//
//  Created by WillyChen on 2023/5/8.
//

import UIKit

class HomePageViewController: UIViewController {
    @IBOutlet weak var musicListTableView: UITableView!
    @IBOutlet weak var playerView: PlayerView!
    @IBOutlet weak var musicInfoView: MusicInformationView!
    @IBOutlet weak var searchView: SearchView!
    
    // MARK: - override
    override func viewDidLoad() {
        super.viewDidLoad()
        
        musicListTableView.clipsToBounds = true
        musicListTableView.layer.cornerRadius = 20
        musicListTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        musicListTableView.backgroundColor = .init(red: 0.94, green: 0.89, blue: 0.97, alpha: 1)
        musicListTableView.dataSource = self
        musicListTableView.delegate = self
        playerView.delegate = self
        searchView.delegate = self
    }
}

// MARK: - UITableViewDataSource
extension HomePageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell.init()
    }
    
}
// MARK: - UITableViewDelegate
extension HomePageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
// MARK: - SearchViewDelegate
extension HomePageViewController: PlayerViewDelegate {
    func clickPlayButton(state: PlayerState) {
        
    }
}
// MARK: - SearchViewDelegate
extension HomePageViewController: SearchViewDelegate {
    func clickSearchButton(searchText: String?) {
    }
}
