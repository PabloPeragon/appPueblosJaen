//
//  URLRequestHelperProtocol.swift
//  appPueblosJaen
//
//  Created by Pablo Peragón Garrido on 18/11/25.
//

import Foundation

protocol URLRequestHelperProtocol {
    // MARK: Properties
    var baseURL: String { get }
    var endpoints: Endpoints { get }
    
    // MARK: Functions
    func listPueblos() -> URLRequest?
    func listLugares(puebloId: Int) -> URLRequest?
    func listFotos(lugarId: Int) -> URLRequest?
}
