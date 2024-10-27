//
//  GithubUserDetailView.swift
//  LearSwift
//
//  Created by Nanda Kista Permana on 26/10/23.
//

import SwiftUI

struct GithubUserDetailView: View {
    
    @State var isFavorite: Bool = false
    @StateObject private var viewModel: GithubUserDetailViewModel
    
    init(username: String) {
        _viewModel = StateObject(wrappedValue: GithubUserDetailViewModel(username: username))
    }
    
    var body: some View {
        NavigationView {
            if (viewModel.isLoading) {
                ProgressView()
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage).foregroundColor(.red)
            } else {
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
                                Text(String(viewModel.user?.repository ?? 0))
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                Text("Repository")
                                    .font(.subheadline)
                            }
                            .frame(maxWidth: .infinity)
                            VStack {
                                Text(String(viewModel.user?.followers ?? 0))
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                Text("Follower")
                                    .font(.subheadline)
                            }
                            .frame(maxWidth: .infinity)
                            VStack {
                                Text(String(viewModel.user?.following ?? 0))
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                Text("Following")
                                    .font(.subheadline)
                            }
                            .frame(maxWidth: .infinity)
                        })
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, 12)
                        Text(viewModel.user?.username ?? "-")
                            .font(.headline)
                            .foregroundColor(.primary)
                        Text(viewModel.user?.location ?? "-")
                    }
                    .padding(.vertical, 12)
                    .padding(.horizontal, 16)
    //                .frame(maxWidth: .infinity, alignment: .leading)
                }
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
        GithubUserDetailView(username: "nandakista")
    }
}
