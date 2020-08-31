//
//  CustomTableViewCell.swift
//  SLTestTask
//
//  Created by apple on 8/27/20.
//  Copyright © 2020 GQt. All rights reserved.
//

import UIKit

final class CustomTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.adjustsFontSizeToFitWidth = false
        }
    }
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // MARK: - Awake From Nib
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let padding = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        //bounds = bounds.inset(by: padding)
        
    }
}
