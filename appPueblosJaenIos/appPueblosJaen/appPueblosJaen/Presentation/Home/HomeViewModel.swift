//
//  HomeViewModel.swift
//  appPueblosJaen
//
//  Created by Pablo Peragón Garrido on 27/11/25.
//
import Foundation

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
        DispatchQueue.main.async {
            Task {
                guard let pueblos = try? await self.repository.listPueblos() else {
                    print("Error al obtener los pueblos: los pueblos son nulos o la solicitud falló.")
                    return
                }
                self.pueblos = pueblos
            }
        }
    }
}
