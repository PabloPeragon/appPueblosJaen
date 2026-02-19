//
//  RemoteDataSourceImpl.swift
//  appPueblosJaen
//
//  Created by Pablo Peragón Garrido on 17/11/25.
//

import Foundation

final class RemoteDataSourceImpl: RemoteDataSourceProtocol {
    
    var urlRequestHelper: URLRequestHelperProtocol = URLRequestHelperImpl()
    
    func listPueblos() async throws -> [Pueblo] {
        //Obtenemos la request
        guard let request = urlRequestHelper.listPueblos() else {
            throw DataError.invalidRequest
        }
        
        //Obtenemos los datos y la respuesta del servidor
        let (data, response) = try await URLSession.shared.data(for: request)
        
        //Trasnformación de la respuesta a una HTTPURLResponse para acceder al código de estado.
        guard let http = response as? HTTPURLResponse else {
            throw DataError.invalidResponse
        }
        
        //Verificamos el status code
        switch http.statusCode {
         
        // Si el status code es 200, caso de exito, y devuelve lista de pueblos.
        case 200:
            // Convierte los datos a un array de pueblos y los devuelve
            do {
                return try JSONDecoder().decode([Pueblo].self, from: data)
            } catch {
                throw DataError.decoding(error)
            }
        
        case 400: throw DataError.badRequest
            
        case 401: throw DataError.unauthorized
            
        case 500: throw DataError.serverError
            
        default: throw DataError.unexpectedStatus(http.statusCode)
            
        }
    }
    
    func listLugares(puebloId: Int) async throws -> [LugarImportante] {
        guard let request = urlRequestHelper.listLugares(puebloId: puebloId) else {
            throw DataError.invalidRequest
        }
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let http = response as? HTTPURLResponse else {
            throw DataError.invalidResponse
        }
        
        switch http.statusCode {
        case 200:
            do {
                return try JSONDecoder().decode([LugarImportante].self, from: data)
            } catch {
                throw DataError.decoding(error)
            }
        case 400:
            throw DataError.badRequest
            
        case 401:
            throw DataError.unauthorized
            
        case 500:
            throw DataError.serverError
            
        default:
            throw DataError.unexpectedStatus(http.statusCode)
        }
    }
    

    func listFotos(lugarId: Int) async throws -> [PuebloFoto] {
        guard let request = urlRequestHelper.listFotos(lugarId: lugarId) else {
            throw DataError.invalidRequest
        }
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let http = response as? HTTPURLResponse else {
            throw DataError.invalidResponse
        }
        switch http.statusCode {
        case 200:
            do {
                return try JSONDecoder().decode([PuebloFoto].self, from: data)
            } catch {
                throw DataError.decoding(error)
            }

        case 400: throw DataError.badRequest
            
        case 401: throw DataError.unauthorized
            
        case 500: throw DataError.serverError
        
        default: throw DataError.unexpectedStatus(http.statusCode)
            
        }
    }
    
    func listNegocios(puebloId: Int) async throws -> [Negocio] {
        guard let request = urlRequestHelper.listNegocios(puebloId: puebloId) else {
            throw DataError.invalidRequest
        }
        let (data, response) = try await URLSession.shared.data(for: request)

        guard let http = response as? HTTPURLResponse else {
            throw DataError.invalidResponse
        }
        switch http.statusCode {
        case 200:
            do {
                let decoded = try JSONDecoder().decode([Negocio].self, from: data)
                print("Decodificados \(decoded.count) negocios")
                return decoded
            } catch let decodingError as DecodingError {
                //printamos el campo que falta o esta mal en la base de datos
                print("Error de decodificación en Negocios: \(decodingError)")
                throw DataError.decoding(decodingError)
            } catch {
                throw DataError.decoding(error)
            }
            
        case 400:
            throw DataError.badRequest
        case 401:
            throw DataError.unauthorized
        case 500:
            throw DataError.serverError
        default:
            throw DataError.unexpectedStatus(http.statusCode)
        }
    }
}
