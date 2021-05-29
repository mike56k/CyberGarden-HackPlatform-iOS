//
//  StyleGuides.swift
//  garden
//
//  Created by Михаил Исаченко on 29.05.2021.
//

import UIKit
let black = UIColor.black

extension UITextField{
    
    func styleField() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.borderStyle = .roundedRect
        self.layer.borderColor = black.cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 4
    }
}

