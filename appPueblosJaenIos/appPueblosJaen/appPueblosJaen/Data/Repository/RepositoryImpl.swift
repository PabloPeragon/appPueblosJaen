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
    
}
