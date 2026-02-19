import Foundation
import Observation

@Observable
@MainActor
final class PuebloDetailViewModel {
    // MARK: - Types
    enum LoadState {
        case idle
        case loading
        case loaded
        case failed(String)
    }
    
    // MARK: - Properties
    let repository: RepositoryProtocol
    var puebloActualizado: Pueblo?
    
    private(set) var lugares: [LugarImportante] = []
    private(set) var fotosPueblo: [PuebloFoto] = []
    private(set) var negocios: [Negocio] = []
    
    var negociosConPDF: [Negocio] {
        negocios.filter { $0.notificacion_pdf_url != nil && !($0.notificacion_pdf_url?.isEmpty ?? true) }
    }
    
    var negociosValidos: [Negocio] {
        // Filtramos negocios que tengan al menos nombre
        negocios.filter { !($0.nombre.isEmpty) }
    }
    
    var lugaresState: LoadState = .idle
    var fotosState: LoadState = .idle
    
    init(repository: RepositoryProtocol) {
        self.repository = repository
    }
    
    // MARK: - Fuctions
    /// Carga los lugares de un pueblo por su identificador.
    func fetchLugares(for puebloId: Int) async {
        await MainActor.run { lugaresState = .loading }
        do {
            let fetched = try await repository.listLugares(puebloId: puebloId)
            await MainActor.run {
                self.lugares = fetched
                self.lugaresState = .loaded
            }
        } catch {
            await MainActor.run {
                self.lugares = []
                self.lugaresState = .failed(error.localizedDescription)
            }
        }
    }
    
    /// Carga las fotos de un lugar por su identificador.
    func fetchFotos(for lugarId: Int) async {
        await MainActor.run { fotosState = .loading }
        do {
            let fetched = try await repository.listFotos(lugarId: lugarId)
            await MainActor.run {
                self.fotosPueblo = fetched
                self.fotosState = .loaded
            }
        } catch {
            await MainActor.run {
                self.fotosPueblo = []
                self.fotosState = .failed(error.localizedDescription)
            }
        }
    }
    
    func load(for puebloId: Int) async {
        // Cargamos los negocios de forma aislada
        do {
            let fetchedNegocios = try await repository.listNegocios(puebloId: puebloId)
            await MainActor.run {
                self.negocios = fetchedNegocios
                print("Pueblo \(puebloId): \(fetchedNegocios.count) negocios listos.")
            }
            
        } catch {
            print("Error en negocios para pueblo \(puebloId): \(error)")
        }
        
        
        // Volvemos a pedir los datos del pueblo para ver si han cambiado
        do {
            let todos = try await repository.listPueblos()
            if let actualizado = todos.first(where: { $0.id == puebloId }) {
                await MainActor.run {
                    self.puebloActualizado = actualizado
                }
            }
        } catch {
            print("Error al actualizar datos básicos: \(error)")
        }
        
        
        // Cargamos lugares actualizados
        await fetchLugares(for: puebloId)
        
        // Si no hay lugares, no hay fotos que cargar
        guard !lugares.isEmpty else {
            await MainActor.run {
                self.fotosState = .failed("No se encontraron lugares para cargar fotos.")
            }
            return
        }
        
        
        // Cargamos fotos
        await fetchFotosConsolidadas()
    }
    
    // Función auxiliar para limpiar el código de load
    private func fetchFotosConsolidadas() async {
        await MainActor.run { self.fotosState = .loading }
        do {
            let allFotos: [[PuebloFoto]] = try await withThrowingTaskGroup(of: [PuebloFoto].self) { group in
                for lugar in lugares {
                    let lugarId = lugar.id
                    group.addTask { [repository] in
                        try await repository.listFotos(lugarId: lugarId)
                    }
                }
                
                var collected: [[PuebloFoto]] = []
                for try await fotos in group {
                    collected.append(fotos)
                }
                return collected
            }
            let flattened = allFotos.flatMap { $0 }
            await MainActor.run {
                self.fotosPueblo = flattened
                self.fotosState = .loaded
            }
        } catch {
            await MainActor.run {
                self.fotosState = .failed(error.localizedDescription)
                print("Error al refrescar fotos: \(error.localizedDescription)")
                
            }
        }
    }
}

