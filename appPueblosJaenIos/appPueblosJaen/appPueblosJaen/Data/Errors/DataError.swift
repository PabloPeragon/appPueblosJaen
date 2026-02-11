//
//  DataError.swift
//  appPueblosJaen
//
//  Created by Pablo Peragón Garrido on 31/12/25.
//

import Foundation

enum DataError: LocalizedError {
    case invalidRequest
    case invalidResponse
    case badRequest
    case unauthorized
    case serverError
    case noInternet
    case unexpectedStatus(Int)
    case decoding(Error)

    var errorDescription: String? {
        switch self {
        case .invalidRequest:
            return "La solicitud no es válida."
        case .invalidResponse:
            return "La respuesta del servidor no es válida."
        case .badRequest:
            return "Solicitud incorrecta."
        case .unauthorized:
            return "No autorizado."
        case .serverError:
            return "Error del servidor."
        case .noInternet:
            return "Sin conexión a Internet. Comprueba tu cobertura."
        case .unexpectedStatus(let code):
            return "Código de estado inesperado: \(code)."
        case .decoding(let underlying):
            return "Error al decodificar: \(underlying.localizedDescription)"
        }
    }
}
