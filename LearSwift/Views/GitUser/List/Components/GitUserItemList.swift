//
//  GitUserItemList.swift
//  LearSwift
//
//  Created by Nanda Kista Permana on 26/10/23.
//

import SwiftUI

struct GitUserItemList: View {
    
    let username: String
    let gitUrl: String
    let avatar: String
    
    var body: some View {
        HStack {
            AsyncImage(
                url: URL(string: avatar),
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
                    Text(username)
                    Text(gitUrl)
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
            username: "John Doe",
            gitUrl: "https://github.com/john-doe",
            avatar: "https://ui-avatars.com/api/?name=John+Doe"
        )
    }
}
