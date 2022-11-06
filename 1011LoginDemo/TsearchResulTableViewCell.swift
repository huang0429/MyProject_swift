//
//  TsearchResulTableViewCell.swift
//  1011LoginDemo
//
//  Created by 黃筱珮 on 2022/10/26.
//

import UIKit

class TsearchResulTableViewCell: UITableViewCell {

    @IBOutlet weak var studentIdLabel: UILabel!
    @IBOutlet weak var scanningDateLabel: UILabel!
    
    @IBOutlet weak var qrcodeLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
