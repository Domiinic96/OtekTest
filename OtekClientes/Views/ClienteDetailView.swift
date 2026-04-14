//
//  ClienteDetailView.swift
//  OtekClientes
//
//  Created by Luis Santana on 13/4/26.
//

import SwiftUI



import SwiftUI

struct ClienteDetailView: View {
    
    @EnvironmentObject var viewModel: ClienteViewModel
    let clienteDetail: Cliente
    let showHeader: Bool
    
    var body: some View {
        List {
            
            if showHeader{
                Section {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("\(clienteDetail.nombre) \(clienteDetail.apellido)")
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        HStack {
                            Image(systemName: "phone")
                            Text(clienteDetail.telefono)
                        }
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 6)
                }
            }
            
            
            Section(header: Text("Direcciones")) {
                
                if clienteDetail.direcciones.isEmpty {
                    Text("No hay direcciones registradas")
                        .foregroundColor(.secondary)
                } else {
                    ForEach(clienteDetail.direcciones, id: \.self) { direccion in
                        
                        VStack(alignment: .leading, spacing: 8) {
                            
                            Label(direccion.calle, systemImage: "mappin.and.ellipse")
                                .font(.headline)
                            
                            Label("Casa \(direccion.numeroCasa)", systemImage: "house")
                            
                            Label(direccion.ciudad, systemImage: "building.2")
                                .foregroundColor(.secondary)
                        }
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        .listRowInsets(EdgeInsets())
                        .padding(.vertical, 4)
                        .swipeActions {
                            Button(role: .destructive) {
                                
                                withAnimation {
                                    viewModel.deleteDireccion(cliente: clienteDetail, id: direccion.id)
                                }
                                
                            } label: {
                                Label("Eliminar", systemImage: "trash")
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Cliente")
        .navigationBarTitleDisplayMode(.inline)
    }
}


#Preview {
    ClienteDetailView(clienteDetail: .init(nombre: "Luis", apellido: "Santana", telefono: "8296489596", direcciones: [Direccion(calle: "1era", ciudad: "Santo Domingo", numeroCasa: "1"), Direccion(calle: "jual ibarra", ciudad: "Santo Domingo", numeroCasa: "1")]), showHeader: true)
}
