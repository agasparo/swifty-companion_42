//
//  SkillsTableViewCell.swift
//  swifty-companion
//
//  Created by arthur on 01/11/2020.
//

import UIKit

class SkillsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var SkillsName: UILabel!
    @IBOutlet weak var SkillsLevel: UILabel!
    @IBOutlet weak var SkillsPercent: UIProgressView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
