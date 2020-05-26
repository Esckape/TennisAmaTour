//
//  BorderButton.swift
//  Timeline
//
//  Created by Edi Stern on 3/10/17.
//  Copyright © 2017 Edi Stern. All rights reserved.
//

import UIKit

class BorderButton: UIButton {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.black.cgColor
        clipsToBounds = true
        contentEdgeInsets = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        setTitleColor(UIColor.black, for: .normal)
        setTitleColor(UIColor.black, for: .highlighted)
        self.backgroundColor = UIColor.clear;
    }
}
