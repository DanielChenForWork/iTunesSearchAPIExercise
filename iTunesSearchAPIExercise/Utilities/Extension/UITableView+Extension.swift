//
//  UITableView+Extension.swift
//  iTunesSearchAPIExercise
//
//  Created by WillyChen on 2023/5/8.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(withType: T.Type, specialId: String? = nil) -> T? {
        
        let key = "\(T.description())\(specialId ?? "")"
        
        var cell = self.dequeueReusableCell(withIdentifier: key)
        
        if cell == nil {
            let nib = UINib.init(nibName: T.description().components(separatedBy: ".").last ?? "", bundle: Bundle.init(for: T.self))
            
            self.register(nib, forCellReuseIdentifier: key)
            cell = self.dequeueReusableCell(withIdentifier: key)
        }
        cell?.selectionStyle = .none
        
        return cell as? T
    }
}
