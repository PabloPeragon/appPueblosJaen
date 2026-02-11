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

    
    //Propiedad para controlar si mostramos una alerta de error al actualizar
    var showRefreshError: Bool = false
    var lastErrorMessage: String = ""
    
    // MARK: Init
    init(repository: RepositoryProtocol, pueblos: [Pueblo] = []) {
        self.repository = repository
        self.pueblos = pueblos
    }
    
    // MARK: Functions
    
    func refreshPueblos() async {
        do {
            let fetchedPueblos = try await repository.listPueblos()
            // Si tiene éxito, actualizamos la lista
            self.pueblos = fetchedPueblos
        } catch let error as DataError {
            // Si falla, guardamos el mensaje pero NO vaciamos "pueblos"
            self.lastErrorMessage = error.errorDescription ?? "Error al actualizar"
            self.showRefreshError = true
        } catch {
            self.lastErrorMessage = "Error inesperado"
            self.showRefreshError = true
        }
    }
    /*
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
    */
}
