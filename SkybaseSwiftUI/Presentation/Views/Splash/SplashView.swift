//
//  SplashView.swift
//  SkybaseSwiftUI
//
//  Created by Nanda Kista Permana on 29/10/24.
//

import SwiftUI

struct SplashView: View {
    @ViewBuilder
    private var backgroundColor: some View {
        Color.primaryColor.ignoresSafeArea()
    }
    
    var body: some View {
        ZStack {
            backgroundColor
            ProgressView()
                .tint(Color.white)
                .scaleEffect(1.5)
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
            .environmentObject(AuthManager())
    }
}
