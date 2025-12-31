//
//  RemoteDataSourceProtocol.swift
//  appPueblosJaen
//
//  Created by Pablo Peragón Garrido on 17/11/25.
//

import Foundation

protocol RemoteDataSourceProtocol {
    
    // MARK: Properties
    var urlRequestHelper: URLRequestHelperProtocol { get }
    
    // MARK: Functions
    func listPueblos() async throws -> [Pueblo]
    func listLugares(puebloId: Int) async throws -> [LugarImportante]
    func listFotos(lugarId: Int) async throws -> [PuebloFoto]
}

