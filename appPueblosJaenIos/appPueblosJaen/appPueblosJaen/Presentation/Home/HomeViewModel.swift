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
    var pueblos: [Pueblo]
    
    // MARK: Init
    init(repository: RepositoryProtocol, pueblos: [Pueblo] = []) {
        self.repository = repository
        self.pueblos = pueblos
    }
    
    // MARK: Functions
    func fetchPueblos() {
        Task {
            do {
                let pueblos = try await repository.listPueblos()
                await MainActor.run {
                    self.pueblos = pueblos
                }
            } catch {
                await MainActor.run {
                    self.pueblos = []
                }
                print("Error al obtener los pueblos: \(error.localizedDescription)")
            }
            
        }
    }
}
