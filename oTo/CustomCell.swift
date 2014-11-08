//
//  CustomCell.swift
//  oTo
//
//  Created by Kul on 10/15/2557 BE.
//  Copyright (c) 2557 Kul.com. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    


    @IBOutlet weak var cellImage: UIImageView!
    
    @IBOutlet weak var leftLabel: UILabel!
    
    @IBOutlet weak var rightLabel: UILabel!
    
    @IBOutlet weak var centerLabel: UILabel!
    func setCell(leftLabelText: String, rightLabelText: String, centerLabelText: String)
    
    {
        self.leftLabel.text = leftLabelText
        self.rightLabel.text = rightLabelText
        self.centerLabel.text = centerLabelText
//        self.cellImage.image = imageData
//        self.cellImage.image = UIImage(named:"Image.jpg")
    }

    
}
