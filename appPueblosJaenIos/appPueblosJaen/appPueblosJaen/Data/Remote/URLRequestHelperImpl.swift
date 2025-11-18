//
//  URLRequestHelperImpl.swift
//  appPueblosJaen
//
//  Created by Pablo Peragón Garrido on 18/11/25.
//

import Foundation

final class URLRequestHelperImpl: URLRequestHelperProtocol {
    
    // MARK: Properties
    var baseURL: String = "https://kmxacmsqybtwbebqhwnu.supabase.co"
    var endpoints: Endpoints = Endpoints()
    
    
    func ListPueblos() -> URLRequest? {
        return nil
    }
}
