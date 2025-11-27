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
}
