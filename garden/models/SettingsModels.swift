//
//  SettingsModels.swift
//  template
//
//  Created by Михаил Исаченко on 29.05.2021.
//

import Foundation

struct Section {
    let title: String
    let options: [Option]
}

struct Option {
    let title: String
    let handler: () -> Void
}
