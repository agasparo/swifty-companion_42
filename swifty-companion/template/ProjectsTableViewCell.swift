//
//  ProjectsTableViewCell.swift
//  swifty-companion
//
//  Created by arthur on 01/11/2020.
//

import UIKit

class ProjectsTableViewCell: UITableViewCell {

    @IBOutlet weak var ProjectName: UILabel!
    @IBOutlet weak var ProjectValue: UILabel!
    @IBOutlet weak var ProjectStatus: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
