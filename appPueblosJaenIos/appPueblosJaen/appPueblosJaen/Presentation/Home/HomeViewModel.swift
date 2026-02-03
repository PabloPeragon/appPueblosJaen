//
//  HomeViewModel.swift
//  appPueblosJaen
//
//  Created by Pablo Peragón Garrido on 27/11/25.
//
import Foundation
import Observation

@Observable
@MainActor
final class HomeViewModel {
    
    // MARK: Properties
    let repository: RepositoryProtocol
    var pueblos: [Pueblo] = []
    
    // MARK: Init
    init(repository: RepositoryProtocol) {
        self.repository = repository
        fetchPueblos()
    }
    
    // MARK: Functions
    func fetchPueblos() {
        Task {
            do {
                self.pueblos = try await repository.listPueblos()
            } catch {
                self.pueblos = []
                print("Error al obtener los pueblos: \(error.localizedDescription)")
            }
            
        }
    }
}
