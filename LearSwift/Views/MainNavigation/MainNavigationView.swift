//
//  MainNavigationView.swift
//  LearSwift
//
//  Created by Nanda Kista Permana on 28/08/24.
//

import SwiftUI

struct MainNavigationView: View {
    
    @State var selectedTab: Int = 0
    
    var body: some View {
        TabView(
            selection: $selectedTab,
            content:  {
                GithubUserView(selectedTab: $selectedTab)
                    .tabItem {
                        Image(systemName: "rectangle.stack.person.crop.fill")
                        Text("Github Users")
                    }
                    .tag(0)
                
                FavoriteView()
                    .tabItem {
                        Image(systemName: "heart.fill")
                        Text("Favorite User")
                    }
                    .tag(1)
                
                ProfileView()
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("Profile")
                    }
                    .tag(2)
            }
        ).accentColor(.red)
    }
}

#Preview {
    MainNavigationView()
}
