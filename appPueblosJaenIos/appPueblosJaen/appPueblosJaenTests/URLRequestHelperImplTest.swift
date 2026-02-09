//
//  URLRequestHelperImplTest.swift
//  appPueblosJaenTests
//
//  Created by Pablo Jesús Peragón Garrido on 9/2/26.
//

import XCTest
@testable import appPueblosJaen

final class URLRequestHelperImplTests: XCTestCase {

    

    @MainActor
    func test_listPueblos_buildsURLMethodAndHeaders() throws {
        let helper = URLRequestHelperImpl()
        helper.baseURL = "https://api.example.com"
        helper.token = "TEST_TOKEN"

        let request = helper.listPueblos()
        XCTAssertNotNil(request)
        XCTAssertEqual(request?.httpMethod, "GET")
        XCTAssertEqual(request?.url?.absoluteString, "https://api.example.com/rest/v1/pueblos")

        XCTAssertEqual(request?.value(forHTTPHeaderField: "Accept"), "application/json")
        
        XCTAssertEqual(request?.value(forHTTPHeaderField: "Authorization"), "Bearer TEST_TOKEN")
        XCTAssertEqual(request?.value(forHTTPHeaderField: "apikey"), "TEST_TOKEN")
    }

    @MainActor
    func test_listLugares_buildsURLHeadersAndQueryItems() throws {
        let helper = URLRequestHelperImpl()
        helper.baseURL = "https://api.example.com"
        helper.token = "TEST_TOKEN" // Inyecta el token

        let puebloId = 42
        let request = helper.listLugares(puebloId: puebloId)
        XCTAssertNotNil(request)
        XCTAssertEqual(request?.httpMethod, "GET")

        guard let url = request?.url, let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            return XCTFail("URL inválida")
        }
        XCTAssertEqual(components.scheme, "https")
        XCTAssertEqual(components.host, "api.example.com")
        XCTAssertEqual(components.path, "/rest/v1/lugares_importantes")

        let items = components.queryItems ?? []
        func value(for name: String) -> String? { items.first(where: { $0.name == name })?.value }

        XCTAssertEqual(value(for: "pueblo_id"), "eq.\(puebloId)")
        XCTAssertEqual(value(for: "activo"), "is.true")
        XCTAssertEqual(value(for: "order"), "orden.asc")

        // Headers básicos
        XCTAssertEqual(request?.value(forHTTPHeaderField: "Accept"), "application/json")
        XCTAssertEqual(request?.value(forHTTPHeaderField: "Authorization"), "Bearer TEST_TOKEN")
        XCTAssertEqual(request?.value(forHTTPHeaderField: "apikey"), "TEST_TOKEN")
    }

    @MainActor
    func test_listFotos_buildsURLHeadersAndQueryItems() throws {
        let helper = URLRequestHelperImpl()
        helper.baseURL = "https://api.example.com"
        helper.token = "TEST_TOKEN" // Inyecta el token

        let lugarId = 99
        let request = helper.listFotos(lugarId: lugarId)
        XCTAssertNotNil(request)
        XCTAssertEqual(request?.httpMethod, "GET")

        guard let url = request?.url, let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            return XCTFail("URL inválida")
        }
        XCTAssertEqual(components.scheme, "https")
        XCTAssertEqual(components.host, "api.example.com")
        XCTAssertEqual(components.path, "/rest/v1/fotos_lugares")

        let items = components.queryItems ?? []
        func value(for name: String) -> String? { items.first(where: { $0.name == name })?.value }

        XCTAssertEqual(value(for: "lugar_id"), "eq.\(lugarId)")
        XCTAssertEqual(value(for: "order"), "orden.asc")

        // Headers básicos
        XCTAssertEqual(request?.value(forHTTPHeaderField: "Accept"), "application/json")
        XCTAssertEqual(request?.value(forHTTPHeaderField: "Authorization"), "Bearer TEST_TOKEN")
        XCTAssertEqual(request?.value(forHTTPHeaderField: "apikey"), "TEST_TOKEN")
    }

    @MainActor
    func test_listPueblos_withInvalidBaseURL_returnsNil() {
        let helper = URLRequestHelperImpl()
        helper.baseURL = "ht!tp://invalid-url" // Intencionadamente inválida

        let request = helper.listPueblos()
        XCTAssertNil(request, "Con baseURL inválida, debe devolver nil")
    }
}
