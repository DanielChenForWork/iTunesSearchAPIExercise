//
//  LoadingView.swift
//  iTunesSearchAPIExercise
//
//  Created by WillyChen on 2023/5/8.
//

import UIKit

class LoadingView: NibView {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    static let spTag = 875193168123
    //MARK: - init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSetup()
    }
    //MARK: - private
    private override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        initSetup()
    }
    private func initSetup() {
        activityIndicator.startAnimating()
    }
}

extension LoadingView {
    func hide(delayTime: TimeInterval) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayTime) {
            self.activityIndicator.stopAnimating()
            self.removeFromSuperview()
        }
    }
    
    private static func removeAllSkeletonFrom(view: UIView) {
        let oldSub = view.subviews
        for item in oldSub where item.tag == LoadingView.spTag {
            if let loadingView = item as? LoadingView {
                loadingView.hide(delayTime: 0)
            }
        }
    }
    
    static func show(on view: UIView) -> LoadingView {

        self.removeAllSkeletonFrom(view: view)
        
        let loadingView = LoadingView()
        loadingView.tag = LoadingView.spTag
        
        DispatchQueue.main.async {
            view.addSubview(loadingView)

            loadingView.translatesAutoresizingMaskIntoConstraints = false
            loadingView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
            loadingView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
            loadingView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        }
        
        return loadingView
    }
}
