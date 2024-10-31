//
//  TabItem.swift
//  SkybaseSwiftUI
//
//  Created by Nanda Kista Permana on 31/10/24.
//

import SwiftUI

struct TabItemView<Content: View>: View {
    let title: String
    let image: String
    let tag: Int
    let content: Content
    let onAppear : () -> Void
    
    init(title: String, image: String, tag: Int, @ViewBuilder content: () -> Content, onAppear: @escaping () -> Void) {
        self.title = title
        self.image = image
        self.tag = tag
        self.content = content()
        self.onAppear = onAppear
    }
    
    var body: some View {
        NavigationStack {
            content
                .navigationTitle(title)
        }
        .tabItem {
            Image(systemName: image)
            Text(title)
        }
        .tag(tag)
        .onAppear(perform: {
            onAppear()
        })
    }
}
