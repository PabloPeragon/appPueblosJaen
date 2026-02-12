//
//  RootViewModel.swift
//  appPueblosJaen
//
//  Created by Pablo Jesús Peragón Garrido on 11/2/26.
//

import Foundation
import Observation

enum Status {
    case loading
    case loaded(pueblos: [Pueblo])
    case empty
    case error(DataError)
}


@Observable
@MainActor
final class RootViewModel {
    
    // MARK: Properties
    let repository: RepositoryProtocol
    var status: Status = .loading
    
    
    // MARK: Init
    init(repository: RepositoryProtocol) {
        self.repository = repository
    }
    
    
    // MARK: Functions
    func loadInitialData() async {
        // Evitamos recargas innecesarias si ya tenemos datos
        if case .loaded = status { return }
        
        status = .loading
        
        do {
            let pueblos = try await repository.listPueblos()
            if pueblos.isEmpty {
                status = .empty
            } else {
                status = .loaded(pueblos: pueblos)
            }
        } catch let error as DataError {
            status = .error(error)
        } catch {
            status = .error(.serverError)
        }
    }
    
}
