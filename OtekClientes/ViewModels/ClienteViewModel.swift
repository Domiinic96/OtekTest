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
    @Published var showBanner = false
    @Published var bannerMessage = ""
    @Published var isSuccess = false
    private var storage: Storage
   
    
    init() {
        self.clientes = []
        self.storage = Storage()
        self.clientes = storage.getClientes()
    }
    
    func saveCliente(_ cliente: Cliente) {
        
        let oldCount = clientes.count
        clientes.append(cliente)
        clientes = storage.saveClientes(clientes);
        isSuccess = oldCount < clientes.count
        let message = isSuccess ? OtekConstants.successMessage : OtekConstants.errorDeleteMessage
        showBanner(message: message, success: isSuccess)
        
    }
    
    func deleteCliente(_ cliente: Cliente) {
        
        clientes = storage.deleteCliente(cliente)
        isSuccess = clientes.contains(where: {$0.id == cliente.id}) == false
        
        let message = isSuccess ? OtekConstants.deleteMessage : OtekConstants.errorDeletingDirecciónMessage
        showBanner(message: message, success: isSuccess)
        
        
    }
    
    func deleteAll() {
        
        clientes = storage.deleteallClientes()
        isSuccess = clientes.isEmpty
        let message = isSuccess ? OtekConstants.deleteMessage : OtekConstants.errorDeletingDirecciónMessage
        showBanner(message: message, success: isSuccess)
    }
    
    func deleteDireccion(cliente: Cliente, id: UUID){
        
        clientes = storage.deleteDireccion(cliente: cliente, id: id)
        isSuccess  = clientes.first(where: {$0.id == cliente.id})?.direcciones.count ?? 0 < cliente.direcciones.count
        
        let message = isSuccess ? OtekConstants.succesDireccionMessage : OtekConstants.errorDeletingDirecciónMessage
        showBanner(message: message, success: isSuccess)
        
    }
    
    private func showBanner(message: String, success: Bool) {
        bannerMessage = message
        isSuccess = success
        showBanner = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.showBanner = false
            self.isSuccess = false
        }
    }
    
}



