//
//  ResponseList.swift
//  LearSwift
//
//  Created by Nanda Kista Permana on 29/08/24.
//

import Foundation

struct ResponseList<T: Codable>: Codable {
    let data: [T]
    
    enum CodingKeys: String, CodingKey {
        case data = "items"
    }
 }
