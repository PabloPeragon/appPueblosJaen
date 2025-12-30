//
//  RemoteDataSourceImpl.swift
//  appPueblosJaen
//
//  Created by Pablo Peragón Garrido on 17/11/25.
//

import Foundation

final class RemoteDataSourceImpl: RemoteDataSourceProtocol {
    
    var urlRequestHelper: URLRequestHelperProtocol = URLRequestHelperImpl()
    
    func listPueblos() async throws -> [Pueblo]? {
        //Obtenemos la request
        guard let URLRequest = urlRequestHelper.listPueblos() else {
            print("Error al crear la URLRequest de pueblos")
            return nil
        }
        
        //Obtenemos los datos y la respuesta del servidor
        let (data, response) = try await URLSession.shared.data(for: URLRequest)
        
        //Trasnformación de la respuesta a una HTTPURLResponse para acceder al código de estado.
        guard let httpResponse = response as? HTTPURLResponse else {
            print("Error al enviar la respuesta a HTTPURLResponse")
            return nil
        }
        let statusCode = httpResponse.statusCode
        
        //Verificamos el status code
        switch statusCode {
         
        // Si el status code es 200, caso de exito, y devuelve lista de pueblos.
        case 200:
            // Convierte los datos a un array de pueblos y los devuelve
            guard let pueblos = try? JSONDecoder().decode ([Pueblo].self, from: data) else {
                print("Error: error al decodificar la respuesta del servidor")
                return nil
            }
            //print("Pueblos obtenidos correctamente del servidor: \(pueblos)")
            return pueblos
            
            
        case 400:
            print("Error de solicitud incorrecta al obtener los pueblos de la API")
            return nil
            
        case 401:
            print("Error de autenticación al obtener pueblos de la API")
            return nil
            
        case 500:
            print("Error del servidor al obtener pueblos de la API")
            return nil
            
        default:
            print("Error desconocido al obtener pueblos de la API")
            return nil
            

        }
    }
    
    func listLugares(puebloId: Int) async throws -> [LugarImportante]? {
        guard let URLRequest = urlRequestHelper.listLugares(puebloId: puebloId) else {
            print("Error al crear la URLRequest de lugares para el pueblo \(puebloId)")
            return nil
        }
        let (data, response) = try await URLSession.shared.data(for: URLRequest)
        guard let httpResponse = response as? HTTPURLResponse else {
            print("Error al enviar la respuesta a HTTPURLResponse (lugares)")
            return nil
        }
        switch httpResponse.statusCode {
        case 200:
            guard let lugares = try? JSONDecoder().decode([LugarImportante].self, from: data) else {
                print("Error: error al decodificar la respuesta del servidor (lugares)")
                return nil
            }
            return lugares
        case 400:
            print("Error de solicitud incorrecta al obtener los lugares de la API")
            return nil
        case 401:
            print("Error de autenticación al obtener lugares de la API")
            return nil
        case 500:
            print("Error del servidor al obtener lugares de la API")
            return nil
        default:
            print("Error desconocido al obtener lugares de la API")
            return nil
        }
    }

    func listFotos(lugarId: Int) async throws -> [PuebloFoto]? {
        guard let URLRequest = urlRequestHelper.listFotos(lugarId: lugarId) else {
            print("Error al crear la URLRequest de fotos para el lugar \(lugarId)")
            return nil
        }
        let (data, response) = try await URLSession.shared.data(for: URLRequest)
        guard let httpResponse = response as? HTTPURLResponse else {
            print("Error al enviar la respuesta a HTTPURLResponse (fotos)")
            return nil
        }
        switch httpResponse.statusCode {
        case 200:
            guard let fotos = try? JSONDecoder().decode([PuebloFoto].self, from: data) else {
                print("Error: error al decodificar la respuesta del servidor (fotos)")
                return nil
            }
            return fotos
        case 400:
            print("Error de solicitud incorrecta al obtener las fotos de la API")
            return nil
        case 401:
            print("Error de autenticación al obtener fotos de la API")
            return nil
        case 500:
            print("Error del servidor al obtener fotos de la API")
            return nil
        default:
            print("Error desconocido al obtener fotos de la API")
            return nil
        }
    }
}
