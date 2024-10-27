//
//  ProfileView.swift
//  LearSwift
//
//  Created by Nanda Kista Permana on 28/08/24.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    
    var body: some View {
        NavigationView {
            if (viewModel.isLoading) {
                ProgressView()
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage).foregroundColor(.red)
            } else {
                VStack(spacing: 8, content: {
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
                    Text(viewModel.dataObj?.name ?? "-")
                        .font(.headline)
                        .foregroundColor(.primary)
                    Text(viewModel.dataObj?.bio ?? "-")
                        .font(.caption)
                        .foregroundColor(.primary)
                    Spacer().frame(height: 10)
                    HStack{
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
                    }
                    Spacer().frame(height: 10)
                    if let company = viewModel.dataObj?.company {
                        HStack {
                            Image(systemName: "building")
                                .foregroundColor(.black)
                            Text(company)
                                .font(.subheadline)
                        }
                    }
                    if let location = viewModel.dataObj?.location {
                        HStack {
                            Image(systemName: "location")
                                .foregroundColor(.black)
                            Text(location)
                                .font(.subheadline)
                        }
                    }
                })
            }
        }
        .navigationBarTitle("Profile")
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
