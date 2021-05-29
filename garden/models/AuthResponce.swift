//
//  AuthResponce.swift
//  template
//
//  Created by Михаил Исаченко on 29.05.2021.
//

import Foundation
struct AuthResponse: Codable {
    let access_token: String
    let token_type: String
    let user_id: Int

}
