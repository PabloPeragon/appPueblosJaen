//
//  Pueblo.swift
//  appPueblosJaen
//
//  Created by Pablo Peragón Garrido on 14/11/25.
//

import Foundation

struct Pueblo: Identifiable, Decodable {
    let id: Int
    let nombre: String
    let codigoPostal: String?
    let habitantes: Int?
    let latitud: Double?
    let longitud: Double?
    let comarca: String?
    let descripcion: String?
    let urlEscudo: String?
    let altitud: Int?
    let superficie: Double?
    let gentilicio: String?
    
}
