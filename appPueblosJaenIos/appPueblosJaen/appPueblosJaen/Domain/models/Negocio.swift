//
//  Negocio.swift
//  appPueblosJaen
//
//  Created by Pablo Jesús Peragón Garrido on 14/2/26.
//

import Foundation

struct Negocio: Identifiable, Decodable, Hashable {
    let id: Int
    let pueblo_id: Int
    let categoria_id: Int?
    let nombre: String
    let descripcion: String?
    let descripcion_corta: String?
    let direccion: String?
    let telefono: String?
    let movil: String?
    let email: String?
    let web: String?
    let instagram: String?
    let facebook: String?
    let twitter: String?
    let latitud: Double?
    let longitud: Double?
    let horario: [String: String]?
    let es_premium: Bool?
    let fecha_inicio_premium: String?
    let fecha_fin_premium: String?
    let orden_destacado: Int?
    let visualizaciones: Int?
    let activo: Bool?
    let verificado: Bool?
    let fecha_verificacion: String?
    let propietario_email: String?
    let propietario_nombre: String?
    let created_at: String?
    let updated_at: String?
    let notificacion_pdf_url: String?
    let imagen_principal_url: String?
    
}
