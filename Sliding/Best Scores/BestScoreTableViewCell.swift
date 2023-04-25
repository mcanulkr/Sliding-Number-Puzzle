//
//  BestScoreTableViewCell.swift
//  Sliding
//
//  Created by Muratcan on 7.04.2023.
//

import UIKit

class BestScoreTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var itemView: UIView!
    @IBOutlet weak var itemNumberLabel: UILabel!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemScoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        itemView.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
