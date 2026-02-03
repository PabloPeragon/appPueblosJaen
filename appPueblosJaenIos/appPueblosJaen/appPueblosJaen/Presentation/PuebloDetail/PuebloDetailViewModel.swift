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

    private(set) var lugares: [LugarImportante] = []
    private(set) var fotosPueblo: [PuebloFoto] = []

    var lugaresState: LoadState = .idle
    var fotosState: LoadState = .idle

    init(repository: RepositoryProtocol) {
        self.repository = repository
    }

    // MARK: - Fuctions
    /// Carga los lugares de un pueblo por su identificador.
    func fetchLugares(for puebloId: Int) async {
        lugaresState = .loading
        do {
            self.lugares = try await repository.listLugares(puebloId: puebloId)
            lugaresState = .loaded
        } catch {
            self.lugares = []
            lugaresState = .failed(error.localizedDescription)
        }
    }

    /// Carga las fotos de un lugar por su identificador.
    func fetchFotos(for lugarId: Int) async {
        fotosState = .loading
        do {
            self.fotosPueblo = try await repository.listFotos(lugarId: lugarId)
            fotosState = .loaded
        } catch {
            self.fotosPueblo = []
            fotosState = .failed(error.localizedDescription)
        }
    }

    func load(for puebloId: Int) async {
        // Cargamos lugares primero
        await fetchLugares(for: puebloId)

        // Si no hay lugares, no hay fotos que cargar
        guard !lugares.isEmpty else { return }

        // Cargamos fotos de todos los lugares en paralelo y consolidamos resultados
        fotosState = .loading
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
            // Aplanamos en un solo array
            self.fotosPueblo = allFotos.flatMap { $0 }
            self.fotosState = .loaded
        } catch {
            self.fotosPueblo = []
            self.fotosState = .failed(error.localizedDescription)
        }
    }
}
