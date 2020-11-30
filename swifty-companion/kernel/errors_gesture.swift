//
//  errors_gesture.swift
//  swifty-companion
//
//  Created by arthur on 29/10/2020.
//

import Foundation
import UIKit

class Errors_gesture {
    
    func handle_error(name: String, error: String, btn_msg: String) -> UIAlertController {
        
        let alert = UIAlertController(title: name, message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: btn_msg, style: .default, handler: nil))
        return (alert)
    }
}
