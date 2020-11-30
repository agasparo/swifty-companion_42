//
//  token_gesture.swift
//  swifty-companion
//
//  Created by arthur on 01/11/2020.
//

import Foundation

class TokeGest {
    
    func IsTokenOut(content: Token_gesture) -> Bool {
        
        let expiration = content.created_at + content.expires_in
        let now = NSDate().timeIntervalSince1970
        
        if expiration <= Int(now) {
            return true
        }
        return false
    }
}
