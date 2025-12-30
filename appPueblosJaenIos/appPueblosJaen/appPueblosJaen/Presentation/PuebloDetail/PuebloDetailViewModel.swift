import Foundation

@MainActor
final class PuebloDetailViewModel: ObservableObject {
    
    // MARK: Properties
    let repository: RepositoryProtocol
    @Published var lugares: [LugarImportante] = []
    @Published var fotosPueblo: [PuebloFoto] = []
    
    init(repository: RepositoryProtocol) {
        self.repository = repository
    }
    
    // MARK: Fuctions
    func fetchLugares(for lugarImp: LugarImportante) async {
        Task {
            guard let lugares = try? await self.repository.listLugares(puebloId: lugarImp.pueblo_id) else {
                print("Error al obtener el id del pueblo en listLugares")
                return
            }
            self.lugares = lugares
        }
    }
    
    func fetchFotos(for lugarId: PuebloFoto) async {
        Task {
            guard let fotosPueblo = try? await self.repository.listFotos(lugarId: lugarId.lugar_id) else {
                print("Error al obtener el id del lugar en PuebloFoto")
                return
            }
            self.fotosPueblo = fotosPueblo
            
            }
        }
    }
