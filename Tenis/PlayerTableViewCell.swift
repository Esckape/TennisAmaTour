//
//  PlayerTableViewCell.swift
//  Tenis
//
//  Created by Edi Stern on 6/22/17.
//  Copyright © 2017 Edi Stern. All rights reserved.
//

import UIKit

class PlayerTableViewCell: UITableViewCell {
    @IBOutlet weak var lblIndex : UILabel!;
    @IBOutlet weak var lblNume : UILabel!;
    @IBOutlet weak var lblPunctaj : UILabel!;
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
