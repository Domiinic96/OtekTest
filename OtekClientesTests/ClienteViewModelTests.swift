//
//  ClienteViewModelTests.swift
//  OtekClientes
//
//  Created by Luis Santana on 13/4/26.
//

import XCTest
@testable import OtekClientes


final class ClienteViewModelTests: XCTestCase {
    
    var viewModel: ClienteViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = ClienteViewModel()
        _ = viewModel.deleteAll()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    // MARK: - SAVE CLIENTE
    
    func test_saveCliente_shouldAddClient() {
        
        let cliente = Cliente(
            nombre: "Luis",
            apellido: "Santana",
            telefono: "123",
            direcciones: []
        )
        
        let result = viewModel.saveCliente(cliente)
        
        XCTAssertTrue(result)
        XCTAssertEqual(viewModel.clientes.count, 1)
    }
    
    // MARK: - DELETE CLIENTE
    
    func test_deleteCliente_shouldRemoveClient() {
        
        let cliente = Cliente(
            nombre: "Ana",
            apellido: "Perez",
            telefono: "111",
            direcciones: []
        )
        
        _ = viewModel.saveCliente(cliente)
        
        let result = viewModel.deleteCliente(cliente)
        
        XCTAssertTrue(result)
        XCTAssertTrue(viewModel.clientes.contains(where: { $0.id == cliente.id }) == false)
    }
    
    // MARK: - DELETE ALL
    
    func test_deleteAll_shouldRemoveEverything() {
        
        let cliente1 = Cliente(nombre: "A", apellido: "B", telefono: "1", direcciones: [])
        let cliente2 = Cliente(nombre: "C", apellido: "D", telefono: "2", direcciones: [])
        
        _ = viewModel.saveCliente(cliente1)
        _ = viewModel.saveCliente(cliente2)
        
        let result = viewModel.deleteAll()
        
        XCTAssertTrue(result)
        XCTAssertEqual(viewModel.clientes.count, 0)
    }
    
    // MARK: - DELETE DIRECCION
    
    func test_deleteDireccion_shouldRemoveAddress() {
        
        let direccion = Direccion(calle: "1", ciudad: "SD", numeroCasa: "10")
        
        let cliente = Cliente(
            nombre: "Luis",
            apellido: "S",
            telefono: "999",
            direcciones: [direccion]
        )
        
        _ = viewModel.saveCliente(cliente)
        
        guard let saved = viewModel.clientes.first else {
            XCTFail("Cliente no guardado")
            return
        }
        
        let result = viewModel.deleteDireccion(cliente: saved, id: direccion.id)
        
        XCTAssertTrue(result)
    }
}
