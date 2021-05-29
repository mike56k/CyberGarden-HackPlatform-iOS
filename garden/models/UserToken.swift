//
//  UserToken.swift
//  template
//
//  Created by Михаил Исаченко on 28.05.2021.
//

import Foundation
struct UserToken: Codable {
    let access_token: String
    let token_type: String
    let user_id: Int
    
    
}
