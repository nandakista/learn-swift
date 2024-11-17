//
//  ConditionalFrameModifier.swift
//  SkybaseSwiftUI
//
//  Created by Nanda Kista Permana on 17/11/24.
//

import SwiftUI

struct ConditionalFrameModifier: ViewModifier {
    let wrapContent: Bool
    
    func body(content: Content) -> some View {
        Group {
            if wrapContent {
                content
            } else {
                content.frame(maxWidth: .infinity)
            }
        }
    }
}
