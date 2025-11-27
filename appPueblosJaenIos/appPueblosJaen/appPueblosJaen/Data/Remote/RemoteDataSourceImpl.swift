//
//  RemoteDataSourceImpl.swift
//  appPueblosJaen
//
//  Created by Pablo Peragón Garrido on 17/11/25.
//

import Foundation

final class RemoteDataSourceImpl: RemoteDataSourceProtocol {
    
    
    var urlRequestHelper: URLRequestHelperProtocol = URLRequestHelperImpl()
    
    func listPueblos() async throws -> ([Pueblo]) {
        []

    }
}
