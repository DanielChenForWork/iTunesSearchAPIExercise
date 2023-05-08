//
//  NibView.swift
//  iTunesSearchAPIExercise
//
//  Created by WillyChen on 2023/5/8.
//

import UIKit

class NibView: UIView {
    @IBOutlet weak var view: UIView!
    
    // MARK: - override
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    // MARK: - required
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    // MARK: - internal
    func afterSetUp() {
        
    }
    
    func getView() -> UIView? {
        return self.view
    }
    // MARK: - private
    private func setup() {
        backgroundColor = UIColor.clear
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
        
        addSubview(view)
        
        self.afterSetUp()
    }
    
    private func loadViewFromNib() -> UIView {
        return UINib(nibName: String(describing: type(of: self)),
                     bundle: Bundle(for: type(of: self)))
        .instantiate(withOwner: self, options: nil).first as? UIView ?? UIView()
    }
}

