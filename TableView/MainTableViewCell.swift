//
//  MainTableViewCell.swift
//  TableView
//
//  Created by 서민재 on 2022/01/26.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var aLati: UILabel!
    @IBOutlet weak var aLong: UILabel!
    @IBOutlet weak var aAqi: UILabel!
    @IBOutlet weak var aAddress: UILabel!
    
    @IBOutlet weak var bLati: UILabel!
    @IBOutlet weak var bLong: UILabel!
    @IBOutlet weak var bAqi: UILabel!
    @IBOutlet weak var bAddress: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
