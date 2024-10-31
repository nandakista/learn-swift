//
//  SplashView.swift
//  SkybaseSwiftUI
//
//  Created by Nanda Kista Permana on 29/10/24.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Color.primaryColor.ignoresSafeArea()
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
