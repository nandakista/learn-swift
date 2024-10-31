//
//  MainNavigationView.swift
//  LearSwift
//
//  Created by Nanda Kista Permana on 28/08/24.
//

import SwiftUI

struct TabItem {
    let id: Int
    let title: String
    let image: String
    let view: AnyView
}

struct MainNavigationView: View {
    
    @State var selectedTab: Int = 0
    
    var body: some View {
        TabView(
            selection: $selectedTab,
            content: {
                TabItemView(
                    title: "Github Users",
                    image: "rectangle.stack.person.crop.fill",
                    tag: 0,
                    content: { GithubUserView(selectedTab: $selectedTab) },
                    onAppear: {
                        selectedTab = 0
                    }
                )
                
                TabItemView(
                    title: "Favorite User",
                    image: "heart.fill",
                    tag: 1,
                    content: { FavoriteView() },
                    onAppear: { 
                        selectedTab = 1
                    }
                )
                
                TabItemView(
                    title: "Profile",
                    image: "person.fill",
                    tag: 2,
                    content: { ProfileView() },
                    onAppear: {
                        selectedTab = 2
                    }
                )
            }
        )
        .accentColor(.red)
    }
}

struct MainNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MainNavigationView()
        }
        .environmentObject(dev.githubUserViewModel)
    }
}
