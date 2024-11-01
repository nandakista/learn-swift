//
//  ViewExtension.swift
//  SkybaseSwiftUI
//
//  Created by Nanda Kista Permana on 01/11/24.
//

import SwiftUI

extension View {
    func onTapDismissKeyboard() -> some View {
        self.onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}
