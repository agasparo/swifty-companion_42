//
//  HistoCViewController.swift
//  swifty-companion
//
//  Created by arthur on 31/10/2020.
//

import UIKit

class HistoCViewController: ViewController {

    @IBOutlet weak var TableHisto: UITableView!
    
    var HistoT = UserHisto()
    
    var kernelHisto: HistoContent?
    var Parent: ViewController?
    
    var kh:HistoContent? {
        didSet {
            kernelHisto = kh
        }
    }
    
    var auto:ViewController? {
        didSet {
            Parent = auto
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        HistoT.setData(content: kernelHisto?.UserContent, time: kernelHisto?.UserTime)
        HistoT.setKernelHisto(cl: self)
        HistoT.setParent(cl: self.Parent!)
        TableHisto.delegate = HistoT
        TableHisto.dataSource = HistoT
    }
    
    func HistoCompletion() {
        
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func goBack(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }

}
