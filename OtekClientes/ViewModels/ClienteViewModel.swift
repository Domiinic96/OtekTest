//
//  ClienteViewModel.swift
//  OtekClientes
//
//  Created by Luis Santana on 13/4/26.
//



import Combine
import Foundation

class ClienteViewModel: ObservableObject {
    
    @Published var clientes: [Cliente]
    private var storage: Storage
    
    init() {
        self.clientes = []
        self.storage = Storage()
        self.clientes = storage.getClientes()
    }
    
    func saveCliente(_ cliente: Cliente) -> Bool {
        clientes.append(cliente)
        clientes = storage.saveClientes(clientes);
        return !clientes.isEmpty
    }
    
    func deleteCliente(_ cliente: Cliente) -> Bool {
        
        clientes = storage.deleteCliente(cliente)
        return clientes.contains(where: {$0.id == cliente.id}) == false
        
    }
    
    func deleteAll() -> Bool {
        
        clientes = storage.deleteallClientes()
        return clientes.isEmpty
    }
    
    func deleteDireccion(cliente: Cliente, id: UUID) -> Bool{
        
        clientes = storage.deleteDireccion(cliente: cliente, id: id)
        let eliminado  = clientes.first(where: {$0.id == cliente.id})?.direcciones.count ?? 0 < cliente.direcciones.count
        
        return eliminado
    }
    
}



