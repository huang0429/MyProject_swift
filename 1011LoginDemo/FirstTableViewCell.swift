//
//  FirstTableViewCell.swift
//  1011LoginDemo
//
//  Created by 黃筱珮 on 2022/10/19.
//

import UIKit

class FirstTableViewCell: UITableViewCell {

    
    @IBOutlet weak var labelNewsID: UILabel!
    @IBOutlet weak var labelNewsTitle: UILabel!
    @IBOutlet weak var labelNewsDate: UILabel!
    
    var NewsSchema: newsSchema?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
