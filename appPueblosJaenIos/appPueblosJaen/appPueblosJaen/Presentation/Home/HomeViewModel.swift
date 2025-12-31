//
//  HomeViewModel.swift
//  appPueblosJaen
//
//  Created by Pablo Peragón Garrido on 27/11/25.
//
import Foundation

@MainActor
final class HomeViewModel: ObservableObject {
    
    // MARK: Properties
    let repository: RepositoryProtocol
    @Published var pueblos: [Pueblo] = []
    
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
