//
//  FavViewController.swift
//  swifty-companion
//
//  Created by arthur on 01/11/2020.
//

import UIKit

class FavViewController: ViewController {

    @IBOutlet weak var TableFav: UITableView!
    
    var TableGest = UserFav()
    var DataClass: Favorite?
    var Parent: ViewController?
    
    var infoObject:Favorite? {
        didSet {
            DataClass = infoObject!
        }
    }
    
    var infoParent:ViewController? {
        didSet {
            Parent = infoParent!
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        TableGest.setParent(cl: self.Parent!)
        TableGest.setData(content: self.DataClass!.FavContent)
        TableGest.setPrev(cl: self)
        TableFav.delegate = TableGest
        TableFav.dataSource = TableGest
    }
    
    func FavCompletion() {
        
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func goBack(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
}
