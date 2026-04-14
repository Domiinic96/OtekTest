//
//  Storage.swift
//  OtekClientes
//
//  Created by Luis Santana on 13/4/26.
//

import Foundation

struct Storage{
    
    private let defaults = UserDefaults.standard
    
    func saveClientes(_ clientes: [Cliente]) -> [Cliente] {
        let encoder = JSONEncoder()
        guard let encoded = try? encoder.encode(clientes) else {
            return []
        }
        defaults.set(encoded, forKey: "clientes")
        return getClientes()
    }
    
    
    func getClientes() -> [Cliente] {
        let decoder = JSONDecoder()
        guard let savedClientes = defaults.data(forKey: "clientes"),
              let clientes = try? decoder.decode([Cliente].self, from: savedClientes) else {
            return []
        }
        return clientes
    }
    
    func updateCliente(_ cliente: Cliente) -> [Cliente] {
        
        let index = getClientes().firstIndex(where: {$0.id == cliente.id}) ?? -1
        if index >= 0 {
            let clientes = getClientes()
            var updatedClientes = clientes
            updatedClientes[index] = cliente
            return saveClientes(updatedClientes)
        }
        return []
    }
    
    func deleteCliente(_ cliente: Cliente) -> [Cliente] {
        let clientes = getClientes()
        let newListClientes = clientes.filter { $0.id != cliente.id }
        
        return saveClientes(newListClientes)
    }
    
    func deleteDireccion(cliente: Cliente, id: UUID) -> [Cliente] {
        
        let singleCliente = getClientes().first(where: { $0.id == cliente.id })
        if var cliente = singleCliente {
            cliente.direcciones.removeAll(where: { $0.id == id})
            return updateCliente(cliente)
        }
        return getClientes()
    }
    
    func deleteallClientes() -> [Cliente] {
        return saveClientes([])
    }
    
}
