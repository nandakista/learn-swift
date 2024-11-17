//
//  PrimaryButton.swift
//  SkybaseSwiftUI
//
//  Created by Nanda Kista Permana on 17/11/24.
//

import SwiftUI

struct PrimaryButton: View {
    let title: String
    var disabled: Bool? = false
    var wrapContent: Bool? = false
    var leadingIcon: Image? = nil
    var trailingIcon: Image? = nil
    let action: () -> Void

    var body: some View {
        Button(action: {
            action()
        }) {
            HStack {
                if let leadingIcon = leadingIcon {
                    leadingIcon
                        .foregroundColor(.white)
                        .padding(.leading, 5)
                }
                
                Text(title)
                    .fontWeight(.semibold)
                
                if let trailingIcon = trailingIcon {
                    trailingIcon
                        .foregroundColor(.white)
                        .padding(.trailing, 10)
                }
            }
            .modifier(ConditionalFrameModifier(wrapContent: wrapContent!))
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding(.horizontal)
        }
        .disabled(disabled!)
    }
}

#Preview {
    PrimaryButton(
        title: "Primary Button",
        disabled: false,
        leadingIcon: Image(systemName: "person.fill"),
        trailingIcon: Image(systemName: "arrow.right.circle.fill"),
        action: {
            
        }
    )
}
