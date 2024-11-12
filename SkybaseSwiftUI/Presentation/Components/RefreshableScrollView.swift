//
//  RefreshableScrollView.swift
//  SkybaseSwiftUI
//
//  Created by Nanda Kista Permana on 10/11/24.
//


import SwiftUI

struct RefreshableScrollView<Content: View>: UIViewRepresentable {
    var content: Content
    private var onRefresh: (() async -> Void)?
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(context.coordinator, action: #selector(Coordinator.handleRefresh), for: .valueChanged)
        scrollView.refreshControl = refreshControl
        
        let hostingController = UIHostingController(rootView: content)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(hostingController.view)
        
        NSLayoutConstraint.activate([
            hostingController.view.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            hostingController.view.topAnchor.constraint(equalTo: scrollView.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
        
        context.coordinator.hostingController = hostingController
        context.coordinator.refreshControl = refreshControl
        context.coordinator.onRefresh = onRefresh
        
        return scrollView
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        context.coordinator.hostingController?.rootView = content
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject {
        var parent: RefreshableScrollView
        var hostingController: UIHostingController<Content>?
        var refreshControl: UIRefreshControl?
        var onRefresh: (() async -> Void)?
        
        init(parent: RefreshableScrollView) {
            self.parent = parent
        }
        
        @objc func handleRefresh() {
            guard let onRefresh = onRefresh else { return }
            Task {
                await onRefresh()
                DispatchQueue.main.async {
                    self.refreshControl?.endRefreshing()
                }
            }
        }
    }
    
    func onRefresh(_ action: @escaping () async -> Void) -> Self {
        var copy = self
        copy.onRefresh = action
        return copy
    }
}

// Extension to add `.refreshable` support to RefreshableScrollView
extension View {
    /// Use this extension to handle .refreshable on ScrollView.
    ///
    /// Because the .refreshable on ScrollView is not optimized yet.
    /// The issue is when you use .refreshable inside ScrollView, the loading indicator disappear early without waiting
    /// the async completion
    func refreshableX(action: @escaping () async -> Void) -> some View {
        RefreshableScrollView {
            self
        }
        .onRefresh(action)
    }
}
