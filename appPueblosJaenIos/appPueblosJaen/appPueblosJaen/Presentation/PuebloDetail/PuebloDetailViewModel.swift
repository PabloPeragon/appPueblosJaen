import Foundation

@MainActor
final class PuebloDetailViewModel: ObservableObject {
    // MARK: - Types
    enum LoadState {
        case idle
        case loading
        case loaded
        case failed(String)
    }

    // MARK: - Properties
    let repository: RepositoryProtocol

    @Published private(set) var lugares: [LugarImportante] = []
    @Published private(set) var fotosPueblo: [PuebloFoto] = []

    @Published var lugaresState: LoadState = .idle
    @Published var fotosState: LoadState = .idle

    init(repository: RepositoryProtocol) {
        self.repository = repository
    }

    // MARK: - API
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
}
