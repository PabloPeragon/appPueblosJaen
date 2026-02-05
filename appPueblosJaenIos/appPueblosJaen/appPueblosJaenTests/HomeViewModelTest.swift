//
//  HomeViewModelTest.swift
//  appPueblosJaenTests
//
//  Created by Pablo Jesús Peragón Garrido on 5/2/26.
//

import XCTest
@testable import appPueblosJaen


final class HomeViewModelTest: XCTestCase {
    
    // Datos simulados de ejemplo
    private let samplePueblos: [Pueblo] = [
        Pueblo(id: 1, nombre: "Jaén", codigo_postal: "23001", habitantes: 112921, latitud: 37.7796, longitud: -3.7849, comarca: "Sierra Sur", descripcion: nil, url_escudo: nil, altitud: 573, superficie: 424.3, gentilicio: "jiennense"),
        Pueblo(id: 2, nombre: "Úbeda", codigo_postal: "23400", habitantes: 34000, latitud: 38.0110, longitud: -3.3700, comarca: "La Loma", descripcion: nil, url_escudo: nil, altitud: 748, superficie: 402.0, gentilicio: "ubetense"),
        Pueblo(id: 3, nombre: "Jamilena", codigo_postal: "23658", habitantes: nil, latitud: nil, longitud: nil, comarca: nil, descripcion: nil, url_escudo: nil, altitud: nil, superficie: nil, gentilicio: nil)
    ]
    
    @MainActor
    func test_fetchPueblos_success_setsPueblos() async {
        // Given: un repositorio que devuelve datos simulados
        let repo = RepositoryMock(pueblos: samplePueblos)
        
        // When: creamos el HomeViewModel (su init llama a fetchPueblos())
        let sut = HomeViewModel(repository: repo)
        
        // Then: esperamos a que termine la tarea interna
        // Pequeño delay para permitir a la Task del ViewModel completar en el main actor
        try? await Task.sleep(nanoseconds: 100_000_000) // 100 ms
        
        XCTAssertEqual(sut.pueblos, samplePueblos)
        XCTAssertEqual(repo.listPueblosCallCount, 1)
        
    }
    
    @MainActor
    func test_fetchPueblos_failure_setsEmpty() async {
        // Given: un repositorio que lanza error
        let repo = RepositoryMock(pueblos: [], error: DataError.serverError)

        // When
        let sut = HomeViewModel(repository: repo)

        // Then
        try? await Task.sleep(nanoseconds: 100_000_000) // 100ms

        XCTAssertTrue(sut.pueblos.isEmpty)
        XCTAssertEqual(repo.listPueblosCallCount, 1)
    }
    
}
