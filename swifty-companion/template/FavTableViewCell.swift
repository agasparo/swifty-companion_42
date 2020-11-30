//
//  FavTableViewCell.swift
//  swifty-companion
//
//  Created by arthur on 01/11/2020.
//

import UIKit

class UserFav: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var data: [String]?
    var Parent: ViewController?
    var Prev: FavViewController?
    
    func setData(content: [String]) {
        
        self.data = content
    }
    
    func setParent(cl: ViewController) {
        
        self.Parent = cl
    }
    
    func setPrev(cl: FavViewController) {
        
        self.Prev = cl
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let name = self.data![indexPath.row]
        self.Prev?.FavCompletion()
        self.Parent?.setHistoAutoCompletion(username: name)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.data?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellFav", for: indexPath)
        
        let name = self.data![indexPath.row]
        
        cell.textLabel?.text = name
        
        return cell
    }
}
