//
//  Cliente.swift
//  OtekClientes
//
//  Created by Luis Santana on 13/4/26.
//

import Foundation

struct Cliente: Codable, Identifiable{
    
    var id: UUID
    var nombre: String
    var apellido: String
    var telefono: String
    var direcciones: [Direccion]
    var createdAt:Date

    init(id: UUID = UUID(), nombre: String, apellido: String, telefono: String, direcciones: [Direccion], createdAt: Date = Date()) {
        self.id = id
        self.nombre = nombre
        self.apellido = apellido
        self.telefono = telefono
        self.direcciones = direcciones
        self.createdAt = createdAt
    }
    
    
}
