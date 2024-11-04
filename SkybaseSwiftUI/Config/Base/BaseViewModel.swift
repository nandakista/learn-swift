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
    
    /*
     State for ui in the page, example is in [StateView]
     */
    @Published var isEmpty: Bool = true
    @Published var isError: Bool = false
    @Published var isLoading: Bool = false
//    @Published var isLoadingNext: Bool = false
    @Published var canLoadNext: Bool = false
    
    /*
        State for dialog, alert, and similiar
    */
    @Published var isLoadingDialog: Bool = false
    @Published var isErrorDialog: Bool = false
    @Published var errorDialogMessage: String? = nil {
        didSet {
            isErrorDialog = errorDialogMessage != nil
        }
    }
    
    @Published var dataList: [T] = [] {
        didSet {
            isEmpty = dataList.isEmpty && dataObj == nil
        }
    }
    
    @Published var dataObj: T? {
        didSet {
            isEmpty = dataList.isEmpty && dataObj == nil
        }
    }
    
    @Published var errorMessage: String? = nil {
        didSet {
            isError = errorMessage != nil
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
//        if (page > 1) {
//            isLoadingNext = true
//        } else {
//            isLoading = true
//        }
        isLoading = true
        errorMessage = nil
    }
    
    func dismissLoading() {
        isLoading = false
//        isLoadingNext = false
    }
    
    func loadError(error: String) {
        if (isLoading) {
            self.errorMessage = error
            dismissLoading()
        }
        
        if (isLoadingDialog) {
            self.errorDialogMessage = error
            dismissLoadingDialog()
        }
    }
    
    func loadFinish(page:Int? = nil ,data: T? = nil, list: [T] = []) {
        if let data = data {
            dataObj = data
        }
        
        if (!list.isEmpty) {
            dataList.append(contentsOf: list)
        }
        
        if let page = page {
            self.page = page
        }
        canLoadNext = list.count == perPage
        dismissLoading()
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
