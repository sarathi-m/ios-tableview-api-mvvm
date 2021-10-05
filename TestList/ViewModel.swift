//
//  ViewModel.swift
//  TestList
//
//  Created by Parth Sarathi on 7/12/21.
//

import Foundation

protocol ViewModelToViewDelegate: AnyObject {
    func dataFetched()
    func showError(errorDescription: String)
}

class ViewModel: ViewToViewModelDelegate {
    
    weak var delegate: ViewModelToViewDelegate?
   
    //private(set) variables value can only be set by view model.
    private(set) var users: Users? {
        didSet {
            self.delegate?.dataFetched()
        }
    }
    
    func numberofUsers() -> Int? {
        return users?.count
    }
    
    func userAtIndex(index: Int) -> User? {
        return users?[index]
    }
    
    func fetchData() {
        RequestManager.fetchData(url: "https://jsonplaceholder.typicode.com/users") { [unowned self] (response: Result<Users?, NetworkError>) in
            DispatchQueue.main.async {
                switch response {
                    case .failure(let err):
                        self.delegate?.showError(errorDescription: err.localizedDescription)
                    case .success(let data):
                        self.users = data
                }
            }
        }
    }
}
