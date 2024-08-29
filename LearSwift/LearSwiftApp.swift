//
//  LearSwiftApp.swift
//  LearSwift
//
//  Created by Nanda Kista Permana on 26/10/23.
//

import SwiftUI

@main
struct LearSwiftApp: App {
    @StateObject private var viewModel = GithubUserViewModel()
//    @StateObject private var githubUserDetailViewModel = GithubUserDetailViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                MainNavigationView()
            }
            .environmentObject(viewModel)
//            .environmentObject(githubUserDetailViewModel)
        }
    }
}
