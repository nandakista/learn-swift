//
//  GitUserItemList.swift
//  SkybaseSwiftUI
//
//  Created by Nanda Kista Permana on 26/10/23.
//

import SwiftUI

struct GitUserItemList: View {
    
    let githubUser: GithubUser
    
    var body: some View {
        HStack {
            AsyncImage(
                url: URL(string: githubUser.avatarUrl ?? ""),
                content: {
                    image in image.resizable()
                }, placeholder: {
                    ProgressView()
                }
            )
            .scaledToFit()
            .frame(width: 50, height: 50)
            .clipShape(Circle())
            
            VStack(
                alignment: .leading,
                spacing: 4,
                content: {
                    Text(githubUser.username ?? "-")
                    Text(githubUser.gitUrl ?? "-")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            )
        }
    }
}

struct GitUserItemList_Previews: PreviewProvider {
    static var previews: some View {
        GitUserItemList(
            githubUser: dev.githubUser
        )
    }
}
