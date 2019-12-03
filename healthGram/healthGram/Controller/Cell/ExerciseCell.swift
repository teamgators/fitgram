//
//  ExerciseCell.swift
//  healthGram
//
//  Created by Sunminder Sandhu on 12/2/19.
//  Copyright © 2019 Russell Wong. All rights reserved.
//

import UIKit

class ExerciseCell: UITableViewCell {

    @IBOutlet weak var exerciseNameTable: UILabel!
    @IBOutlet weak var exerciseTypeLabel: UILabel!
    @IBOutlet weak var equipmentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
