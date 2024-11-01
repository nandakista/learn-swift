//
//  LoadingDialog.swift
//  SkybaseSwiftUI
//
//  Created by Nanda Kista Permana on 30/10/24.
//

import SwiftUI

extension View {
    func alertLoading(isShowing: Binding<Bool>, message: String? = nil) -> some View {
        self.modifier(
            LoadingDialogModifier(
                isShowing: isShowing, 
                message: message
            )
        )
    }
}

struct LoadingDialogModifier: ViewModifier {
    @Binding var isShowing: Bool
    var message: String?
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if isShowing {
                LoadingDialog(message: message)
            }
        }
    }
}

struct LoadingDialog: View {
    var message: String?
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(1.5)
                if let message = message {
                    Text(message)
                        .font(.callout)
                        .foregroundColor(.black)
                }
            }
            .padding(EdgeInsets(top: 24, leading: 24, bottom: 24, trailing: 24))
            .background(Color.white)
            .cornerRadius(10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    LoadingDialog()
}
