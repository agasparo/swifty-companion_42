//
//  Fav.swift
//  swifty-companion
//
//  Created by arthur on 01/11/2020.
//

import Foundation

class Favorite {
    
    var FavContent: [String] = []
    
    func isFav(username: String) -> Bool {
        
        if self.FavContent.contains(username) {
            return true
        }
        return false
    }
    
    func getFav() {
        
        let filename = self.getDocumentsDirectory().appendingPathComponent("FavUser.txt")
        do {
            let text = try String(contentsOf: filename, encoding: .utf8)
            let data = Data(text.utf8)
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String] {
                    self.FavContent = json
                }
            } catch {
                return
            }
        } catch {
            return
        }
    }
    
    func addFav(username: String) -> Bool {
        
        let filename = self.getDocumentsDirectory().appendingPathComponent("FavUser.txt")
        self.FavContent.append(username)
        let str = json(from: self.FavContent)
        do {
            try str!.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
            return true
        } catch {
            self.FavContent = self.FavContent.filter { $0 != username }
            return false
        }
    }
    
    func deleteFav(username: String) -> Bool {
        
        let filename = self.getDocumentsDirectory().appendingPathComponent("FavUser.txt")
        self.FavContent = self.FavContent.filter { $0 != username }
        let str = json(from: self.FavContent)
        do {
            try str!.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
            return true
        } catch {
            self.FavContent.append(username)
            return false
        }
    }
    
    func json(from object:Any) -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
