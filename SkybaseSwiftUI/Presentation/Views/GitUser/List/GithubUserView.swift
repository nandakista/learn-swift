//
//  GithubUserView.swift
//  LearSwift
//
//  Created by Nanda Kista Permana on 26/10/23.
//

import SwiftUI

struct GithubUserView: View {
    @Binding var selectedTab: Int
    @StateObject private var viewModel = GithubUserViewModel(dataSource: GithubDataSource())
    
    var body: some View {
        NavigationView {
            StateView(
                loadingWhen: viewModel.isLoading,
                emptyWhen: viewModel.isEmpty,
                errorWhen: viewModel.isError,
                errorMessage: viewModel.errorMessage,
                content: {
                    List {
                        ForEach(viewModel.dataList) { githubUser in
                            NavigationLink(
                                destination: GithubUserDetailView(username: githubUser.username ?? ""),
                                label: {
                                    GitUserItemList(
                                        githubUser: githubUser
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
                    // Cara lain untuk init load data
                    //.onAppear {
                    //   viewModel.onLoadGithubUser()
                    //}
                }
            )
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
}