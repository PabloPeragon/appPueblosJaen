//
//  RepositoryMock.swift
//  appPueblosJaenTests
//
//  Created by Pablo Jesús Peragón Garrido on 5/2/26.
//

import Foundation
@testable import appPueblosJaen

final class RepositoryMock: RepositoryProtocol {
    //Base de datos ficticia
    var remoteDataSource: RemoteDataSourceProtocol = RemoteDataSourceDummy()
    
    //configuración del Mock
    var pueblosToReturn: [Pueblo]
    var errorToThrow: Error?
    var negociosToReturn: [Negocio] = []
    
    //Trazas para verificar interacciones
    private(set) var listPueblosCallCount: Int = 0
    
    init(pueblos: [Pueblo] = [], error: Error? = nil, negocios: [Negocio] = []) {
        self.pueblosToReturn = pueblos
        self.errorToThrow = error
        self.negociosToReturn = negocios
    }
    
    // MARK: RepositoryProtocol
    func listPueblos() async throws -> [Pueblo] {
        listPueblosCallCount += 1
        if let error = errorToThrow {throw error}
        return pueblosToReturn
    }
    
    func listLugares(puebloId: Int) async throws -> [LugarImportante] {
        return []
    }
    
    func listFotos(lugarId: Int) async throws -> [PuebloFoto] {
        return []
    }
    
    func listNegocios(puebloId: Int) async throws -> [Negocio] {
        if let error = errorToThrow { throw error }
        return negociosToReturn.filter { $0.pueblo_id == puebloId }
    }
}

// MARK: - Dummies auxiliares

private final class RemoteDataSourceDummy: RemoteDataSourceProtocol {
    var urlRequestHelper: URLRequestHelperProtocol { fatalError("No se usa en los tests")}
    
    func listPueblos() async throws -> [Pueblo] { fatalError("No se usa en los tests") }
    
    func listLugares(puebloId: Int) async throws -> [LugarImportante] { fatalError("No se usa en los tests")}
    
    func listFotos(lugarId: Int) async throws -> [PuebloFoto] { fatalError("No se usa en los tests")}
    
    func listNegocios(puebloId: Int) async throws -> [Negocio] { fatalError("No se usa en los tests") }
    
}
