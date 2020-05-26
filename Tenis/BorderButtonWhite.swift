//
//  BorderButton.swift
//  Timeline
//
//  Created by Edi Stern on 3/10/17.
//  Copyright © 2017 Edi Stern. All rights reserved.
//

import UIKit

class BorderButtonWhite: UIButton {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.borderWidth = 3.0
        layer.borderColor = UIColor.white.cgColor
        layer.cornerRadius = 10.0
        clipsToBounds = true
        contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        setTitleColor(UIColor.white, for: .normal)
        setTitleColor(UIColor.white, for: .highlighted)
        self.backgroundColor = UIColor.clear;
    }
}
