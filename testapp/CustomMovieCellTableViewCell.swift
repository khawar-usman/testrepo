//
//  CustomMovieCellTableViewCell.swift
//  testapp
//
//  Created by Tin on 2/3/16.
//  Copyright © 2016 Tin. All rights reserved.
//

import UIKit

class CustomMovieCellTableViewCell: UITableViewCell {


    @IBOutlet var movieImage:UIImageView!
    @IBOutlet var titleHead:UILabel!
        @IBOutlet var titleSubHead:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailByGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        //test func
    }
    
    
}
