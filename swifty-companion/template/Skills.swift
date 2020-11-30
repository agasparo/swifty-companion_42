//
//  Skills.swift
//  swifty-companion
//
//  Created by arthur on 31/10/2020.
//

import UIKit

class UserSkills: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var data: User_gesture?
    var Parent: InfosViewController?
    
    func setData(content: User_gesture) {
        
        self.data = content
    }
    
    func setParent(cl: InfosViewController) {
        
        self.Parent = cl
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var dateDeb: String = "pas de date"
        var dateEnd: String = "pas de date"
        
        let df = DateFormatter()
        df.locale = Locale(identifier: "en_US_POSIX")
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        let ds = DateFormatter()
        ds.dateFormat = "yyyy-MM-dd hh:mm:ss"
        
        if self.data?.cursus_users![indexPath.section].begin_at != nil {
            let beginDate = df.date(from: (self.data?.cursus_users![indexPath.section].begin_at)!)
            dateDeb = ds.string(from: beginDate!)
        }
        
        if self.data?.cursus_users![indexPath.section].end_at != nil {
            let endDate = df.date(from:  (self.data?.cursus_users![indexPath.section].end_at)!)
            dateEnd = ds.string(from: endDate!)
        }
        
        let str = "Date du debut de cursus : " + dateDeb + "\n" + "fin estimee pour le cursus : " + dateEnd
        
        self.Parent?.moreInfos(name_infos: "Plus d'informations", content: str)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return (self.data?.cursus_users!.count)!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.data?.cursus_users![section].skills.count)!
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        label.textAlignment = NSTextAlignment.center;
        label.text = "cursus : " + (self.data?.cursus_users![section].cursus?.name)! + " level : " + String((self.data?.cursus_users![section].level)!)
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SkillsTableViewCell
        
        let name = self.data?.cursus_users![indexPath.section].skills[indexPath.row].name
        
        let note = String((self.data?.cursus_users![indexPath.section].skills[indexPath.row].level)!)
        
        let percent = Float(note)! / 21
        
        cell.SkillsName.text = name
        cell.SkillsLevel.text = note
        cell.SkillsPercent.progress = percent
        
        return cell
    }
}
