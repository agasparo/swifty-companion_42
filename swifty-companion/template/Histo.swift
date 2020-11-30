//
//  Histo.swift
//  swifty-companion
//
//  Created by arthur on 31/10/2020.
//

import UIKit

class UserHisto: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var data: [String]?
    var time: [Date]?
    
    var kernelHisto: HistoCViewController?
    var Parent: ViewController?
    
    func setKernelHisto(cl: HistoCViewController) {
        
        self.kernelHisto = cl
    }
    
    func setParent(cl: ViewController) {
        
        self.Parent = cl
    }
    
    func setData(content: [String]?, time: [Date]?) {
        
        self.data = content
        self.time = time
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let name = self.data![indexPath.row]
        self.Parent?.setHistoAutoCompletion(username: name)
        self.kernelHisto?.HistoCompletion()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.data?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "histoCells", for: indexPath)
        
        let name = self.data![indexPath.row]
        
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let now = df.string(from: self.time![indexPath.row])
            
        cell.textLabel?.text = "[" + now + "] " + name
        
        return cell
    }
}
