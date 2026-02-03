//
//  appPueblosJaenTests.swift
//  appPueblosJaenTests
//
//  Created by Pablo Jesús Peragón Garrido on 3/2/26.
//

import XCTest
@testable import appPueblosJaen

final class appPueblosJaenTests: XCTestCase {
    
    func testModelPueblo() {
        let id = 1
        let nombre = "Texto Nombre"
        let codigoPostal = "1234"
        
        let pueblo = Pueblo(id: 1, nombre: "Texto Nombre", codigo_postal: "1234", habitantes: nil, latitud: nil, longitud: nil, comarca: nil, descripcion: nil, url_escudo: nil, altitud: nil, superficie: nil, gentilicio: nil)
        
        XCTAssertEqual(pueblo.id, id)
        XCTAssertEqual(pueblo.nombre, nombre)
        XCTAssertEqual(pueblo.codigo_postal, codigoPostal)
        XCTAssertNil(pueblo.habitantes)
        
    }
    
    func testModelPuebloFoto() {
        let id = 2
        let lugarId = 3
        let urlFoto = "Http://prueba"
        
        
        let puebloFoto = PuebloFoto(id: 2, lugar_id: 3, url_foto: "Http://prueba", titulo: nil, descripcion: nil, es_portada: nil, orden: nil, created_at: nil)
        
        XCTAssertEqual(puebloFoto.id, id)
        XCTAssertEqual(puebloFoto.lugar_id, lugarId)
        XCTAssertEqual(puebloFoto.url_foto, urlFoto)
        XCTAssertNil(puebloFoto.titulo)
    }
    
    
    func testModelLugarImportante() {
        let id = 12
        let puebloId = 10
        let nombre = "Campo nombre"
        
        
        let lugarImportante = LugarImportante(id: 12, pueblo_id: 10, nombre: "Campo nombre", tipo: nil, descripcion: nil, latitud: nil, longitud: nil, direccion: nil, horario_visita: nil, precio_entrada: nil, web: nil, telefono: nil, activo: nil, orden: nil, created_at: nil, update_at: nil)
        
        XCTAssertEqual(lugarImportante.id, id)
        XCTAssertEqual(lugarImportante.pueblo_id, puebloId)
        XCTAssertEqual(lugarImportante.nombre, nombre)
        XCTAssertNil(lugarImportante.descripcion)
    }
}
