//
//  BaseViewModel.swift
//  SkybaseSwiftUI
//
//  Created by Nanda Kista Permana on 27/10/24.
//

import Combine



class BaseViewModel<T>: ObservableObject {
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
    var isError: Bool { return state == .error && !canLoadNext }
    var isLoading: Bool { return state == .loading && !canLoadNext }
    var isSuccess: Bool { return state == .success }
    
    /*
     Pagination
     */
    @Published var canLoadNext: Bool = false
    var isLoadingNext: Bool { return state == .loading && canLoadNext }
    var isErrorNext: Bool { return errorMessage != nil && page > 1 }
    
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
    
    func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .failure(let error):
            loadError(error: error.localizedDescription)
        case .finished:
            break
        }
    }
    
    func loadingState() {
        state = .loading
        errorMessage = nil
    }
    
    func loadError(error: String) {
        if (isLoadingDialog) {
            self.errorDialogMessage = error
            dismissLoadingDialog()
        } else {
            self.errorMessage = error
            state = .error
        }
        
    }
    
    func loadFinish(page: Int? = nil, data: T? = nil, list: [T] = []) {
        if let data = data {
            dataObj = data
        }
        
        if (!list.isEmpty) {
            dataList.append(contentsOf: list)
            if let page = page { self.page = page }
            canLoadNext = list.count >= perPage
        }
        
        if (dataList.isEmpty && dataObj == nil) { state = .empty }
        
        state = .success
        dismissLoadingDialog()
    }
    
    ///
    /// Call this to change and show loading dialog
    ///
    func showLoadingDialog() {
        isLoadingDialog = true
        errorMessage = nil
    }
    
    ///
    /// Call this to change and dismiss loading dialog
    ///
    func dismissLoadingDialog() {
        isLoadingDialog = false
    }
    
    ///
    /// Call this to change and show error dialog
    ///
    func loadingDialogError(error: String) {
        self.errorDialogMessage = error
        dismissLoadingDialog()
    }
}
