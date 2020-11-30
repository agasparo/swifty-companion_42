//
//  competence.swift
//  swifty-companion
//
//  Created by arthur on 31/10/2020.
//

import UIKit

class UserComp: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var data: User_gesture?
    var Parent: InfosViewController?
    
    func setData(content: User_gesture) {
        
        self.data = content
    }
    
    func setParent(cl: InfosViewController) {
        self.Parent = cl
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let desc = self.data?.achievements![indexPath.row].description
        
        self.Parent?.moreInfos(name_infos: "Plus d'informations", content: desc!)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 70.0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.data?.achievements!.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellComp", for: indexPath) as! CompTableViewCell
        
        let name = self.data?.achievements![indexPath.row].name
        
        cell.NameComp.text = name
        cell.ImgComp.image = UIImage(named: "sucess")
        return cell
    }
}
