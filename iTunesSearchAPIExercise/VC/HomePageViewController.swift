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
    
    var viewModel: HomePageVM = HomePageVM.init(musicDMs: nil)
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
        viewModel.delegate = self
    }
    
    deinit {
        viewModel.clean()
    }
    // MARK: - internal
    func showAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "錯誤", message: "查無資料", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "了解", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

// MARK: - UITableViewDataSource
extension HomePageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.searchResultCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let musicDM = viewModel.getCellData(indexPath: indexPath), let cell = tableView.dequeueReusableCell(withType: MusicTableViewCell.self) else {
            return UITableViewCell.init()
        }
        cell.setUp(musicDM: musicDM)
        cell.selectionStyle = .gray
        return cell
    }
    
}
// MARK: - UITableViewDelegate
extension HomePageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectMusic(indexPath: indexPath)
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
        viewModel.startGetData(searchText: searchText)
    }
}

// MARK: - HomePageVMDelegate
extension HomePageViewController: HomePageVMDelegate {
    func dataDidUpdate(status: Bool) {
        DispatchQueue.main.sync {
            self.musicListTableView.reloadData()
            if !status {
                self.showAlert()
            }
        }
    }
}
