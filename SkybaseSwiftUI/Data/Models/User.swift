//
//  User.swift
//  SkybaseSwiftUI
//
//  Created by Nanda Kista Permana on 31/10/24.
//

import Foundation

struct User: Codable, Hashable, Equatable {
    let id: String?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
 }
