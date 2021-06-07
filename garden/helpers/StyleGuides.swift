//
//  StyleGuides.swift
//  garden
//
//  Created by Михаил Исаченко on 29.05.2021.
//

import UIKit
let black = UIColor.black
let lightGreen = UIColor(rgb: 0x43dfa8)

extension UITextField{
    
    func styleField() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.borderStyle = .roundedRect
        self.layer.borderColor = black.cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 4
    }
}

extension UIButton{
    func styleBlackButton(_ title:String) {
        self.backgroundColor = .black
        self.setTitle(title, for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.layer.cornerRadius = 30
    }
    func styleGreenButton(_ title:String) {
        self.setTitle(title, for: .normal)
        self.backgroundColor = lightGreen
        self.layer.cornerRadius = 30
        self.setTitleColor(.black, for: .normal)
    }
    
}

