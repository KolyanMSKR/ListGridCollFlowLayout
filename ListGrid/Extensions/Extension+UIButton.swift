//
//  Extension+UIButton.swift
//  ListGrid
//
//  Created by Admin on 19.05.2020.
//  Copyright © 2020 Mykola Korotun. All rights reserved.
//

import UIKit

extension UIButton {
    
    convenience init(title: String) {
        self.init()
        
        setTitle(title, for: .normal)
        setTitleColor(.blue, for: .normal)
    }
    
}
