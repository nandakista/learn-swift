//
//  GithubUserView.swift
//  LearSwift
//
//  Created by Nanda Kista Permana on 26/10/23.
//

import SwiftUI

struct GithubUserView: View {
    @Binding var selectedTab: Int
    
    var body: some View {
        NavigationView {
            List {
                ForEach(githubUsers) { githubUser in
                    NavigationLink(
                        destination: GithubUserDetailView(username: githubUser.username, gitUrl: githubUser.gitUrl, avatar: githubUser.avatar),
                        label: {
                            GitUserItemList(
                                username: githubUser.username,
                                gitUrl: githubUser.gitUrl,
                                avatar: githubUser.avatar
                            )
                        }
                    )
                }
            }
            .listStyle(.plain)
            .navigationTitle("Github Users")
            .navigationBarItems(
                trailing: HStack(content: {
                    Image(systemName: "heart.fill")
                    .foregroundColor(.red)
                    .onTapGesture {
                        selectedTab = 1
                    }
                    Image(systemName: "gear")
                    .foregroundColor(.black)
                    .onTapGesture {
                        // TODO :
                    }
                })
            )
        }
    }
}

struct GithubUserView_Previews: PreviewProvider {
    static var previews: some View {
        @State var selectedTab: Int = 0
        
        NavigationView {
            GithubUserView(selectedTab: $selectedTab)
        }
    }
}
