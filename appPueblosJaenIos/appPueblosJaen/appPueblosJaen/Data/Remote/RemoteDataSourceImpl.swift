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
}
