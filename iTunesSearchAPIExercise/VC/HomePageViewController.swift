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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

