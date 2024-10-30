//
//  BaseViewModel.swift
//  LearSwift
//
//  Created by Nanda Kista Permana on 27/10/24.
//

import Foundation
import Combine

class BaseViewModel<T>: ObservableObject {
    var cancellables = Set<AnyCancellable>()
    
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
    
    @Published var isEmpty: Bool = true
    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    
    func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
            case .failure(let error):
                loadError(error: error.localizedDescription)
            case .finished:
                break
        }
    }
    
    func loadingState() {
        isLoading = true
        errorMessage = nil
    }
    
    func dismissLoading() {
        isLoading = false
    }
    
    func loadError(error: String) {
        self.errorMessage = error
        dismissLoading()
    }
    
    func loadFinish(data: T? = nil, list: [T] = []) {
        if let data = data {
            dataObj = data
        }
        
        if (!list.isEmpty) {
            dataList = list
        }
        dismissLoading()
    }
}
