//
//  PuebloFoto.swift
//  appPueblosJaen
//
//  Created by Pablo Peragón Garrido on 23/12/25.
//

import Foundation

struct PuebloFoto: Identifiable, Decodable, Hashable {
    let id: Int
    let lugar_id: Int
    let url_foto: String
    let titulo: String?
    let descripcion: String?
    let es_portada: Bool?
    let orden: Int?
    let created_at: String?
    
}
