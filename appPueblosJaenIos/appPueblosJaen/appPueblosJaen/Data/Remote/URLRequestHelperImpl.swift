//
//  URLRequestHelperImpl.swift
//  appPueblosJaen
//
//  Created by Pablo Peragón Garrido on 18/11/25.
//

import Foundation

final class URLRequestHelperImpl: URLRequestHelperProtocol {
    
    // MARK: Properties
    var baseURL: String = {
        guard let value = Bundle.main.object(forInfoDictionaryKey: "SUPABASE_URL") as? String, !value.isEmpty else {
            fatalError("Falta SUPABASE_URL en Info.plist")
        }
        return value
    }()
    var endpoints: Endpoints = Endpoints()
    
    
    // MARK: Functions
    func listPueblos() -> URLRequest? {
        
        // Get URL
        guard let url = URL(string: "\(baseURL)\(endpoints.pueblos)") else {
            print("Error al crear la url \(baseURL)\(endpoints.pueblos)")
            return nil
        }
        
        // Get token
        guard let token = Bundle.main.object(forInfoDictionaryKey: "SUPABASE_ANON_KEY") as? String, !token.isEmpty else {
            assertionFailure("No se ha podido obtener SUPABASE_ANON_KEY del Info.plist")
            return nil
        }
        
        
        // Create the request
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue(token, forHTTPHeaderField: "apikey")
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        return urlRequest
    }
    
    func listLugares(puebloId: Int) -> URLRequest? {
        var components = URLComponents(string: "\(baseURL)\(endpoints.lugares)")
        components?.queryItems = [
            URLQueryItem(name: "pueblo_id", value: "eq.\(puebloId)"),
            URLQueryItem(name: "activo", value: "is.true"),
            URLQueryItem(name: "orden", value: "orden.asc")
        ]
        guard let url = components?.url else {
            print("Error al crear la url de lugares: \(String(describing: components))")
            return nil
        }
        
        guard let token = Bundle.main.object(forInfoDictionaryKey: "SUPABASE_ANON_KEY") as? String, !token.isEmpty else {
            assertionFailure("No se ha podido obtener SUPABASE_ANON_KEY del Info.plist")
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue(token, forHTTPHeaderField: "apikey")
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        return urlRequest
    }
    
    func listFotos(lugarId: Int) -> URLRequest? {
        var components = URLComponents(string: "\(baseURL)\(endpoints.fotos)")
        components?.queryItems = [
            URLQueryItem(name: "lugar_id", value: "eq.\(lugarId)"),
            URLQueryItem(name: "orden", value: "orden.asc")
        ]
        guard let url = components?.url else {
            print("Error al crear la url de fotos: \(String(describing: components))")
            return nil
        }
        
        guard let token = Bundle.main.object(forInfoDictionaryKey: "SUPABASE_ANON_KEY") as? String, !token.isEmpty else {
            assertionFailure("No se ha podido obtener SUPABASE_ANON_KEY del Info.plist")
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue(token, forHTTPHeaderField: "apikey")
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        return urlRequest
    }
}
