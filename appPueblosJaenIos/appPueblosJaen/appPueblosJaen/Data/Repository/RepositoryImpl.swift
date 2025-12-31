//
//  RepositoryImpl.swift
//  appPueblosJaen
//
//  Created by Pablo Peragón Garrido on 20/11/25.
//

import Foundation

final class RepositoryImpl: RepositoryProtocol {
    

    // MARK: Properties
    var remoteDataSource: RemoteDataSourceProtocol
    
    // MARK: Init
    init(remoteDataSource: RemoteDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }
    
    //MARK: Functions
    func listPueblos() async throws -> [Pueblo]? {
        return try await remoteDataSource.listPueblos()
    }
    
    func listLugares(puebloId: Int) async throws -> [LugarImportante]? {
        return try await remoteDataSource.listLugares(puebloId: puebloId)
        
    }
    func listFotos(lugarId: Int) async throws -> [PuebloFoto]? {
        return try await remoteDataSource.listFotos(lugarId: lugarId)
    }
    
}
