//
//  MyTableVCell.swift
//  SheetDBwithGAS
//
//  Created by MyMBP on 2020/11/15.
//

import UIKit

class MyTableVCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelDrink: UILabel!
    @IBOutlet weak var labelIce: UILabel!
    @IBOutlet weak var labelSweet: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
