//
//  project.swift
//  swifty-companion
//
//  Created by arthur on 31/10/2020.
//

import UIKit

class UserProject: NSObject, UITableViewDelegate, UITableViewDataSource {
 
    var data: User_gesture?
    var Parent: InfosViewController?
    var newDataName: [String] = []
    var newDataStatus: [String] = []
    var newDataNote: [Int] = []
    var newDataRetry: [Int] = []
    var newDataDate: [String] = []
    
    func setData(content: User_gesture) {
        
        self.data = content
    }
    
    func setParent(cl: InfosViewController) {
        
        self.Parent = cl
    }
    
    func setGoodDatas() {
        
        if (self.data?.projects_users!.count == 0) {
            return;
        }
        
        for i in 0...((self.data?.projects_users!.count)! - 1) {
            
            if (self.data?.projects_users![i].cursus_ids![0] == 21) || (self.data?.projects_users![i].cursus_ids![0] == 1) {
                
                self.newDataName.append((self.data?.projects_users![i].project?.name)!)
                self.newDataStatus.append((self.data?.projects_users![i].status)!)
                if self.data?.projects_users![i].final_mark != nil {
                    self.newDataNote.append(Int((self.data?.projects_users![i].final_mark)!))
                } else {
                    self.newDataNote.append(0)
                }
                self.newDataRetry.append((self.data?.projects_users![i].occurrence)!)
                if ((self.data?.projects_users![i].marked_at) != nil) {
                    self.newDataDate.append((self.data?.projects_users![i].marked_at)!)
                } else {
                    self.newDataDate.append("none")
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var dateProj: String = "pas de date"
        
        let df = DateFormatter()
        df.locale = Locale(identifier: "en_US_POSIX")
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        let ds = DateFormatter()
        ds.dateFormat = "yyyy-MM-dd hh:mm:ss"
        
        let retry = self.newDataRetry[indexPath.row]
        if self.newDataDate[indexPath.row] != "none" {
            let datep = df.date(from:  self.newDataDate[indexPath.row])
            dateProj = ds.string(from: datep!)
        }
        
        let str = "Nombre de retry(s) : " + String(retry) + "\n" + "Date de validation : " + dateProj
        
        self.Parent?.moreInfos(name_infos: "Plus d'informations", content: str)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newDataNote.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "projetcell", for: indexPath) as! ProjectsTableViewCell
        
            
        let name = self.newDataName[indexPath.row]
            
        let status = self.newDataStatus[indexPath.row]
            
        let note = self.newDataNote[indexPath.row]
            
        cell.ProjectName.text = name
        cell.ProjectValue.text = String(note)
        cell.ProjectStatus.text = status
        
        cell.ProjectValue.textAlignment = .right
        
        if note < 50 {
            cell.ProjectStatus.textColor = UIColor.red
            cell.ProjectValue.textColor = UIColor.red
        } else {
            cell.ProjectStatus.textColor = UIColor(red: 0, green: 0.5373, blue: 0.1882, alpha: 1.0)
            cell.ProjectValue.textColor = UIColor(red: 0, green: 0.5373, blue: 0.1882, alpha: 1.0)
        }
    
        return cell
    }
}
