//
//  UIImageView.swift
//  SLTestTask
//
//  Created by apple on 8/30/20.
//  Copyright © 2020 GQt. All rights reserved.
//

import UIKit


extension UIImageView {
    
    // MARK: Blur effect for Image View
    func addBlurEffect() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        blurEffectView.frame = self.bounds
        
        // for supporting device rotation
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        blurEffectView.alpha = 0.8
        self.addSubview(blurEffectView)
    }
}

