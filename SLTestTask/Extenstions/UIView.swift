//
//  UIView.swift
//  SLTestTask
//
//  Created by apple on 8/31/20.
//  Copyright © 2020 GQt. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func makeCornerRadius(View: UIView) {
        View.backgroundColor = UIColor.clear
        View.layer.cornerRadius = 15.0
        View.clipsToBounds = true
    }
}
