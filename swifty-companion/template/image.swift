//
//  image.swift
//  swifty-companion
//
//  Created by arthur on 31/10/2020.
//

import UIKit

extension UIImageView {
    
    func load(url: URL) {
        
        DispatchQueue.global().async {
            
            [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
