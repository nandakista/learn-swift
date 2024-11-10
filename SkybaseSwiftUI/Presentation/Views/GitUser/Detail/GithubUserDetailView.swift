//
//  GithubUserDetailView.swift
//  SkybaseSwiftUI
//
//  Created by Nanda Kista Permana on 26/10/23.
//

import SwiftUI

struct GithubUserDetailView: View {
    @State var isFavorite: Bool = false
    @StateObject private var viewModel: GithubUserDetailViewModel
    
    init(username: String) {
        _viewModel = StateObject(wrappedValue: GithubUserDetailViewModel(
            dataSource: GithubDataSource(),
            username: username
        ))
    }
    
    var body: some View {
        StateView(
            loadingWhen: viewModel.isLoading,
            errorWhen: viewModel.isError,
            errorMessage: viewModel.errorMessage,
            content: {
                ScrollView {
                    VStack(alignment: .leading) {
                        HStack(spacing: 20, content: {
                            AsyncImage(
                                url: URL(string: viewModel.dataObj?.avatarUrl ?? "-"),
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
                                Text(String(viewModel.dataObj?.repository ?? 0))
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                Text("Repository")
                                    .font(.subheadline)
                            }
                            .frame(maxWidth: .infinity)
                            VStack {
                                Text(String(viewModel.dataObj?.followers ?? 0))
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                Text("Follower")
                                    .font(.subheadline)
                            }
                            .frame(maxWidth: .infinity)
                            VStack {
                                Text(String(viewModel.dataObj?.following ?? 0))
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                Text("Following")
                                    .font(.subheadline)
                            }
                            .frame(maxWidth: .infinity)
                        })
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, 12)
                        Text(viewModel.dataObj?.username ?? "-")
                            .font(.headline)
                            .foregroundColor(.primary)
                        Text(viewModel.dataObj?.location ?? "-")
                    }
                    .padding(.vertical, 12)
                    .padding(.horizontal, 16)
                    //.frame(maxWidth: .infinity, alignment: .leading)
                }
                .refreshable {
                    await viewModel.onRefresh()
                }
            }
        )
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Image(systemName: isFavorite ? "heart.fill" : "heart")
                    .foregroundColor(.red)
                    .onTapGesture {
                        isFavorite.toggle()
                    }
            }
        }
    }
}

struct GithubUserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GithubUserDetailView(username: "nandakista")
    }
}
