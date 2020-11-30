//
//  HistoContent.swift
//  swifty-companion
//
//  Created by arthur on 31/10/2020.
//

import Foundation


class HistoContent {
    
    var UserContent: [String] = []
    var UserTime: [Date] = []
    
    func addContent(user: String) {
        
        self.UserContent.append(user)
        self.UserTime.append(Date())
    }
}
