//
//  LugarImportante.swift
//  appPueblosJaen
//
//  Created by Pablo Peragón Garrido on 23/12/25.
//

import Foundation

struct LugarImportante: Identifiable,Decodable, Hashable {
    let id: Int
    let pueblo_id: Int
    let nombre: String
    let tipo: String?
    let descripcion: String?
    let latitud: Double?
    let longitud: Double?
    let direccion: String?
    let horario_visita: String?
    let precio_entrada: Int?
    let web: String?
    let telefono: String?
    let activo: Bool?
    let orden: Int?
    let created_at: String?
    let update_at: String?
    
}
