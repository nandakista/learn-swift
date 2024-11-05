//
//  PaginationView.swift
//  SkybaseSwiftUI
//
//  Created by Nanda Kista Permana on 05/11/24.
//

import SwiftUI

struct PaginationList<T: Identifiable & Equatable, Content: View, Loading: View, Error: View>: View {
    let isErrorNext: Bool
    let isLoadingNext: Bool
    let onLoadNext: () -> Void
    let data: [T]
    let itemBuilder: (T) -> Content
    let loadingView: Loading
    let errorView: Error
    
    init(
        errorNextWhen: Bool,
        loadingNextWhen: Bool,
        onLoadNext: @escaping () -> Void,
        data: [T] = [],
        @ViewBuilder loadingView: () -> Loading = { HStack {
            /// There is some bug in SwiftUI when put ProgressView inside the List. Temporary solution are use one of the following :
            /// 1. CustomProgressView()
            /// 2. ProgressView with different id
            ProgressView().id(UUID())
            Text("Loading...").font(.caption)
        }
        },
        @ViewBuilder errorView: () -> Error = { HStack {
            Image(systemName: "arrow.clockwise")
            Text("Tap to try again").font(.caption)
        }
        },
        @ViewBuilder itemBuilder: @escaping (T) -> Content
    ) {
        self.isErrorNext = errorNextWhen
        self.isLoadingNext = loadingNextWhen
        self.onLoadNext = onLoadNext
        self.data = data
        self.itemBuilder = itemBuilder
        self.errorView = errorView()
        self.loadingView = loadingView()
    }
    
    var body: some View {
        List {
            ForEach(data) { datum in
                itemBuilder(datum)
                    .onAppear {
                        if (datum == data.last) {
                            onLoadNext()
                        }
                    }
            }
            
            if isLoadingNext {
                loadingView
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            
            if isErrorNext {
                errorView
                    .onTapGesture {
                        onLoadNext()
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
    }
}

struct PaginationList_Previews: PreviewProvider {
    static var previews: some View {
        
        PaginationList(
            errorNextWhen: true,
            loadingNextWhen: true,
            onLoadNext: dev.githubUserViewModel.onLoadNext,
            data: [dev.githubUser]
        ) { githubUser in
            NavigationLink(value: githubUser) {
                GitUserItemList(githubUser: githubUser)
            }
        }
        .listStyle(.plain)
    }
}
