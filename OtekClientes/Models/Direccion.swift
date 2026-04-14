//
//  Direccion.swift
//  OtekClientes
//
//  Created by Luis Santana on 13/4/26.
//

import Foundation


struct Direccion: Codable, Hashable {
    var id: UUID
    var calle: String
    var ciudad: String
    var numeroCasa: String
    
    init(id: UUID = UUID(), calle: String, ciudad: String, departamento: String? = nil, numeroCasa: String) {
        self.id = id
        self.calle = calle
        self.ciudad = ciudad
        self.numeroCasa = numeroCasa
    }
}
