//
//  SearchView.swift
//  iTunesSearchAPIExercise
//
//  Created by WillyChen on 2023/5/8.
//

import UIKit

protocol SearchViewDelegate: AnyObject {
    func clickSearchButton(searchText: String?)
}

class SearchView: NibView {
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    
    weak var delegate: SearchViewDelegate?
    
    // MARK: - override
    override func afterSetUp() {
        view.backgroundColor = .clear
        
        searchTextField.placeholder = "輸入想要搜尋的歌曲"
        searchButton.setTitle("搜尋", for: .normal)
        searchButton.setTitleColor(.white, for: .normal)
    }
    // MARK: - IBAction
    @IBAction func searchBtnAction(_ sender: Any) {
        delegate?.clickSearchButton(searchText: searchTextField.text)
    }
}
