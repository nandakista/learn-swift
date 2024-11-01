//
//  Login.swift
//  SkybaseSwiftUI
//
//  Created by Nanda Kista Permana on 31/10/24.
//

import Foundation

struct Login: Codable, Hashable {
    let user: User?
    let token: String?
    
    enum CodingKeys: String, CodingKey {
        case user
        case token
    }
 }
