//
//  GithubUserDetailView.swift
//  LearSwift
//
//  Created by Nanda Kista Permana on 26/10/23.
//

import SwiftUI

struct GithubUserDetailView: View {
    
    @State var isFavorite: Bool = false
    @StateObject private var viewModel = GithubUserDetailViewModel()
    
//    let userId: Int
    
    var body: some View {
        NavigationView {
            ScrollView{
                VStack(alignment: .leading) {
                    HStack(spacing: 20, content: {
                        AsyncImage(
                            url: URL(string: viewModel.user?.avatarUrl ?? "-"),
                            content: {
                                image in image.resizable()
                            }, placeholder: {
                                ProgressView()
                            }
                        )
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                        VStack {
                            Text("50")
                                .font(.headline)
                                .foregroundColor(.primary)
                            Text("Repository")
                                .font(.subheadline)
                        }
                        .frame(maxWidth: .infinity)
                        VStack {
                            Text("2350")
                                .font(.headline)
                                .foregroundColor(.primary)
                            Text("Follower")
                                .font(.subheadline)
                        }
                        .frame(maxWidth: .infinity)
                        VStack {
                            Text("50")
                                .font(.headline)
                                .foregroundColor(.primary)
                            Text("Following")
                                .font(.subheadline)
                        }
                        .frame(maxWidth: .infinity)
                    })
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 12)
                    Text("Name")
                        .font(.headline)
                        .foregroundColor(.primary)
                    Text("Lorem ipsum")
                }
                .padding(.vertical, 12)
                .padding(.horizontal, 16)
//                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarItems(trailing: Image(systemName: isFavorite ? "heart.fill" : "heart").foregroundColor(.red).onTapGesture {
            isFavorite.toggle()
        })
    }
}

struct GithubUserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GithubUserDetailView()
    }
}
