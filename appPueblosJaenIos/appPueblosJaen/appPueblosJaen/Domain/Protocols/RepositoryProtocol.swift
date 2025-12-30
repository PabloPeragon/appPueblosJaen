//
//  RepositoryProtocol.swift
//  appPueblosJaen
//
//  Created by Pablo Peragón Garrido on 20/11/25.
//

import Foundation

protocol RepositoryProtocol {
    
    // MARK: Properties
    var remoteDataSource: RemoteDataSourceProtocol { get }
    
    // MARK: Functions
    func listPueblos() async throws -> [Pueblo]?
    func listLugares(puebloId: Int) async throws -> [LugarImportante]?
    func listFotos(lugarId: Int) async throws -> [PuebloFoto]?

}
