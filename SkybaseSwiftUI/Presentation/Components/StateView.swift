//
//  StateView.swift
//  LearSwift
//
//  Created by Nanda Kista Permana on 28/10/24.
//

import SwiftUI

struct StateView<Content: View, LoadingView: View, ErrorView: View, EmptyView: View>: View {
    let isLoading: Bool
    var isEmpty: Bool = false
    let isError: Bool
    let errorMessage: String?
    let loadingContent: () -> LoadingView
    let errorContent: (String) -> ErrorView
    var emptyContent: () -> EmptyView
    let content: () -> Content

    init(
        loadingWhen: Bool,
        emptyWhen: Bool = false,
        errorWhen: Bool = false,
        errorMessage: String? = nil,
        @ViewBuilder loadingView: @escaping () -> LoadingView = { ProgressView() },
        @ViewBuilder errorView: @escaping (String) -> ErrorView = { error in
            Text(error).foregroundColor(.red)
        },
        @ViewBuilder emptyView: @escaping () -> EmptyView = { Text("No content available") },
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.isLoading = loadingWhen
        self.isError = errorWhen
        self.isEmpty = emptyWhen
        self.errorMessage = errorMessage
        self.loadingContent = loadingView
        self.errorContent = errorView
        self.emptyContent = emptyView
        self.content = content
    }

    var body: some View {
        if isLoading {
            loadingContent()
        } else if isError || errorMessage != nil {
            errorContent(errorMessage ?? "An error occurred")
        } else if isEmpty {
            emptyContent()
        } else {
            content()
        }
    }
}
