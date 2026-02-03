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
        let habitantes = 10
        
        let pueblo = Pueblo(id: id, nombre: nombre, codigo_postal: codigoPostal, habitantes: habitantes, latitud: nil, longitud: nil, comarca: nil, descripcion: nil, url_escudo: nil, altitud: nil, superficie: nil, gentilicio: nil)
        
        
        XCTAssertEqual(pueblo.id, id)
        XCTAssertEqual(pueblo.nombre, nombre)
        XCTAssertEqual(pueblo.codigo_postal, codigoPostal)
        XCTAssertEqual(pueblo.habitantes, habitantes)
        XCTAssertNil(pueblo.latitud)
        
    }
    
    func testModelPuebloFoto() {
        let id = 2
        let lugarId = 3
        let urlFoto = "Http://prueba"
        let descripcion = "campo descripcion"
        
        
        let puebloFoto = PuebloFoto(id: id, lugar_id: lugarId, url_foto: urlFoto, titulo: nil, descripcion: descripcion, es_portada: nil, orden: nil, created_at: nil)
        
        XCTAssertEqual(puebloFoto.id, id)
        XCTAssertEqual(puebloFoto.lugar_id, lugarId)
        XCTAssertEqual(puebloFoto.url_foto, urlFoto)
        XCTAssertEqual(puebloFoto.descripcion, descripcion)
        XCTAssertNil(puebloFoto.titulo)
    }
    
    
    func testModelLugarImportante() {
        let id = 12
        let puebloId = 10
        let nombre = "Campo nombre"
        let tipo = "campo tipo"
        
        
        let lugarImportante = LugarImportante(id: id, pueblo_id: puebloId, nombre: nombre, tipo: tipo, descripcion: nil, latitud: nil, longitud: nil, direccion: nil, horario_visita: nil, precio_entrada: nil, web: nil, telefono: nil, activo: nil, orden: nil, created_at: nil, update_at: nil)
        
        XCTAssertEqual(lugarImportante.id, id)
        XCTAssertEqual(lugarImportante.pueblo_id, puebloId)
        XCTAssertEqual(lugarImportante.nombre, nombre)
        XCTAssertEqual(lugarImportante.tipo, tipo)
        XCTAssertNil(lugarImportante.descripcion)
    }
}
