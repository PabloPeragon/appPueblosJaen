//
//  RootViewModel.swift
//  appPueblosJaen
//
//  Created by Pablo Jesús Peragón Garrido on 11/2/26.
//

import Foundation

enum Status {
    case loading
    case loaded(pueblos: [Pueblo])
    case empty
    case error(DataError)
}



final class RootViewModel: ObservableObject {
    
    // MARK: Properties
    let repository: RepositoryProtocol
    @Published var status: Status = .loading
    
    
    // MARK: Init
    init(repository: RepositoryProtocol) {
        self.repository = repository
    }
    
    
    // MARK: Functions
    
}
