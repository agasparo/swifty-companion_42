//
//  CompTableViewCell.swift
//  swifty-companion
//
//  Created by arthur on 01/11/2020.
//

import UIKit

class CompTableViewCell: UITableViewCell {

    @IBOutlet weak var ImgComp: UIImageView!
    @IBOutlet weak var NameComp: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
