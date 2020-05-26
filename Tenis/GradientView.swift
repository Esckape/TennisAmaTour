//
//  GradientView.swift
//  Timeline
//
//  Created by Edi Stern on 3/10/17.
//  Copyright © 2017 Edi Stern. All rights reserved.
//

import Foundation
import UIKit

class GradientView: UIView {
    override open class var layerClass: AnyClass {
        get{
            return CAGradientLayer.classForCoder()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let gradientLayer = self.layer as! CAGradientLayer
        gradientLayer.colors = [UIColor.init(hexString: "#ACF39D").cgColor, UIColor.init(hexString: "#8F6593").cgColor]
    }
}
