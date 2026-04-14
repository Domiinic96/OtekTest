//
//  Direccion.swift
//  OtekClientes
//
//  Created by Luis Santana on 13/4/26.
//

import Foundation


struct Direccion: Codable, Hashable {
    let id: UUID
    let calle: String
    let sector: String
    let ciudad: String
    let numeroCasa: String
    
    init(id: UUID = UUID(), calle: String, sector: String, ciudad: String, departamento: String? = nil, numeroCasa: String) {
        self.id = id
        self.calle = calle
        self.sector = sector
        self.ciudad = ciudad
        self.numeroCasa = numeroCasa
    }
}
