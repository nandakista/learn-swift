//
//  CustomProgressView.swift
//  SkybaseSwiftUI
//
//  Created by Nanda Kista Permana on 05/11/24.
//

import SwiftUI

struct CustomProgressView: View {
//    @State private var isAnimating = false
//    
//    private var animation: Animation {
//        Animation.linear(duration: 1)
//            .repeatForever(autoreverses: false)
//    }
//    
//    var body: some View {
//        Image.icLoading
//            .resizable()
//            .frame(width: 20, height: 20)
//            .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
//            .animation(animation, value: isAnimating)
//            .onAppear {
//                isAnimating = true
//            }
//    }
    
    @State private var isAnimating = false
    let lineWidth: CGFloat = 2.0 
    let strokeColor: Color = .gray
        
        var body: some View {
            Circle()
                .stroke(Color.gray.opacity(0.3), lineWidth: lineWidth) //
                .frame(width: 20, height: 20)
                .overlay(
                    Circle()
                        .trim(from: 0, to: 0.7)
                        .stroke(strokeColor, lineWidth: lineWidth)
                        .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
                        .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false), value: isAnimating)
                )
                .onAppear {
                    isAnimating = true // Start animation when the view appears
                }
        }
}

#Preview {
    CustomProgressView()
}
