//
//  CustomFilmCollectionViewCell.swift
//  SLTestTask
//
//  Created by apple on 8/30/20.
//  Copyright © 2020 GQt. All rights reserved.
//

import UIKit

class CustomFilmCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView! {
        didSet {
            posterImageView.makeCornerRadius(View: posterImageView)
        }
    }
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.textColor = UIColor.redAppColor
        }
    }
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.textColor = UIColor.redAppColor
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}


extension UICollectionViewCell {
    func shadowDecorate() {
        let radius: CGFloat = 15
        contentView.layer.cornerRadius = radius
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1.0)
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
        layer.cornerRadius = radius
    }
}
