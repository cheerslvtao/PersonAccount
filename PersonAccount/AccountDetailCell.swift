//
//  AccountDetailCell.swift
//  PersonAccount
//
//  Created by 吕涛 on 2017/2/15.
//  Copyright © 2017年 Lvtao. All rights reserved.
//

import UIKit

class AccountDetailCell: UITableViewCell {

    
    @IBOutlet weak var income_type: UILabel!
    @IBOutlet weak var income_remarks: UILabel!
    @IBOutlet weak var income_money: UILabel!
    
    @IBOutlet weak var create_time: UILabel!
    
    @IBOutlet weak var midView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        midView.layer.cornerRadius = 5.0
        income_money.clipsToBounds = true
        income_money.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
