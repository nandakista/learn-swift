//
//  BaseViewModel.swift
//  SkybaseSwiftUI
//
//  Created by Nanda Kista Permana on 27/10/24.
//

import Combine

class BaseViewModel<T>: ObservableObject {
    /// Only use when you call the data in the Combine subscription
    /// otherwise when you use async await task you don't need call .store(in: &cancellables)
    var cancellables = Set<AnyCancellable>()
    
    var page: Int = 1
    var perPage: Int = 20
    
    @Published var state: RequestState = .initial
    @Published var dataList: [T] = []
    @Published var dataObj: T?
    @Published var errorMessage: String? = nil
    
    /*
     State for ui in the page, example for [StateView]
     */
    var isInitial: Bool { return state == .initial }
    var isEmpty: Bool { return state == .empty }
    var isError: Bool { return state == .error }
    var isLoading: Bool { return state == .loading }
    var isSuccess: Bool { return state == .success }
    
    /*
     Pagination
     */
    @Published var canLoadNext: Bool = false
    var isLoadingNext: Bool { return state == .loadingNext}
    var isErrorNext: Bool { return state == .errorNext }
    
    /*
     Dialog, Alert, etc.
     */
    @Published var isLoadingDialog: Bool = false
    @Published var isErrorDialog: Bool = false
    @Published var errorDialogMessage: String? = nil {
        didSet {
            isErrorDialog = errorDialogMessage != nil
        }
    }
    
    func onLoadNext(keepAlive: Bool? = true) async {
        fatalError("Subclasses must implement `onLoadNext` method.")
    }
    
    /// Manage state for showing loading view
    ///
    /// - Parameters:
    ///   - keepAlive: When you set `keepAlive` to false it will show the loading view.
    ///   And when you set `keepAlive` to true, it will keep the data and not show the loading view.
    ///   It is perfect to set `keepAlive` to true when you call in pull refresh or load new page in pagination so the loading view is not show
    ///   and only show the loading indicator in pull refersh or in load more
    func loadingState(keepAlive: Bool = false) {
        if (page == 1 && (isInitial || isEmpty || isError)) {
            state = .loading
        } else {
            state = keepAlive ? .loadingNext : .loading
        }
        errorMessage = nil
    }
    
    func loadError(error: String) {
        if (isLoadingDialog) {
            self.errorDialogMessage = error
            dismissLoadingDialog()
        } else {
            self.errorMessage = error
            state = (page == 1) ? .error : .errorNext
        }
        
    }
    
    func loadFinish(page: Int? = nil, data: T? = nil, list: [T] = []) {
        if let data = data {
            dataObj = data
        }
        
        if (!list.isEmpty) {
            if let page = page {
                if (page == 1 && !dataList.isEmpty) {
                    dataList.removeAll()
                }
            }
            dataList.append(contentsOf: list)
            if let page = page { self.page = page }
            canLoadNext = list.count >= perPage
        }
        
        if (dataList.isEmpty && dataObj == nil) { state = .empty }
        
        state = .success
        dismissLoadingDialog()
    }
    
    /// Call this to change and show loading dialog
    func showLoadingDialog() {
        isLoadingDialog = true
        errorMessage = nil
    }
    
    /// Call this to change and dismiss loading dialog
    func dismissLoadingDialog() {
        isLoadingDialog = false
    }
    
    /// Call this to change and show error dialog
    func loadingDialogError(error: String) {
        self.errorDialogMessage = error
        dismissLoadingDialog()
    }
    
    /// Only use when you call the data in the Combine subscription
    /// otherwise when you use async await task you don't need this handling
    func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .failure(let error):
            loadError(error: error.localizedDescription)
        case .finished:
            break
        }
    }
}
