//
//  CustomTextField.swift
//  SkybaseSwiftUI
//
//  Created by Nanda Kista Permana on 17/11/24.
//

import SwiftUI

struct CustomTextField: View {
    let title: String
    @Binding var text: String
    let isError: Bool
    var error: String? = nil
    var onEditingChanged: ((Bool) -> Void)? = nil
    
    var body: some View {
        VStack(
            alignment: .leading,
            content: {
                TextField(title, text: $text, onEditingChanged: { edited in
                    onEditingChanged?(edited)
                })
                .padding()
                .background(Color.gray.opacity(0.15).cornerRadius(10))
                .autocapitalization(.none)
                .disableAutocorrection(true)
                
                if isError {
                    Text(error ?? "Field can not be empty")
                        .foregroundColor(.red)
                        .font(.system(size: 15))
                        .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                        .padding(.horizontal, 0)
                }
            }
        ).padding(.horizontal)
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        @State var username: String = ""
        
        CustomTextField(
            title: "username",
            text: $username,
            isError: true,
            error: "Username can not be empty!",
            onEditingChanged: { edited in
                
            }
        )
    }
}

