//
//  ClienteForm 2.swift
//  OtekClientes
//
//  Created by Luis Santana on 13/4/26.
//


import SwiftUI

struct ClienteForm: View {
    @FocusState var clienteFocused: ClienteFields?
    @FocusState var direccionesFocused: DreccionesFields?
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: ClienteViewModel
    @State private var clienteDraft = Cliente(
        nombre: "",
        apellido: "",
        telefono: "",
        direcciones: []
    )
    @State private var calle = ""
    @State private var ciudad = ""
    @State private var numeroCasa = ""
    @State private var showDireccionSheet = false
    
    var body: some View {
        
        NavigationStack {
            
            VStack(spacing: 20) {
                
                VStack(spacing: 12) {
                    
                    CustomTextField(icon: "person",  placeholder: OtekConstants.nombre, text: $clienteDraft.nombre)
                        .focused($clienteFocused, equals: .nombre)
                    
                    CustomTextField(icon: "person.text.rectangle", placeholder: OtekConstants.apellido, text: $clienteDraft.apellido)
                        .focused($clienteFocused, equals: .apellido)
                    
                    CustomTextField(icon: "phone", placeholder: OtekConstants.telefono, text: $clienteDraft.telefono)
                        .focused($clienteFocused, equals: .telefono)
                        .keyboardType(.numberPad)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                
                List {
                    Section(OtekConstants.direcciones) {
                        
                        if clienteDraft.direcciones.isEmpty {
                            Text(OtekConstants.sinDirecciones)
                                .foregroundColor(.secondary)
                        } else {
                            
                            ForEach(clienteDraft.direcciones, id: \.self) { direccion in
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(direccion.calle)
                                        .font(.headline)
                                    
                                    Text("\(direccion.ciudad) - Casa \(direccion.numeroCasa)")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                            }
                            .onDelete { indexSet in
                                clienteDraft.direcciones.remove(atOffsets: indexSet)
                            }
                        }
                    }
                }
                .frame(maxHeight: 250)
                
                Spacer()
                
                Button {
                    
                    if self.clienteDraft.nombre.isEmpty || self.clienteDraft.apellido.isEmpty || self.clienteDraft.telefono.isEmpty ||
                        self.clienteDraft.direcciones.isEmpty {
                        viewModel.showBanner(message: OtekConstants.completarCampos, success: false)
                        
                    }else{
                        
                        viewModel.saveCliente(clienteDraft)
                        dismiss()
                    }
                } label: {
                    Text(clienteDraft.direcciones.isEmpty ? OtekConstants.agregarParaContinuar : OtekConstants.guardar)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
            .navigationTitle(OtekConstants.nuevoCliente)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showDireccionSheet = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                
                
            }
            .onTapGesture {
                
                self.clienteFocused = nil
                
            }
            
            .sheet(isPresented: $showDireccionSheet) {
                
                NavigationStack {
                    
                    VStack(spacing: 16) {
                        
                        CustomTextField(icon: "mappin", placeholder: OtekConstants.calle, text: $calle)
                            .focused($direccionesFocused, equals: .calle)
                        
                        CustomTextField(icon: "building.2", placeholder: OtekConstants.ciudad, text: $ciudad)
                            .focused($direccionesFocused, equals: .ciudad)
                        
                        CustomTextField(icon: "house", placeholder: OtekConstants.numeroCasa, text: $numeroCasa)
                            .focused($direccionesFocused, equals: .numeroCasa)
                        
                        Spacer()
                    }
                    .padding()
                    .navigationTitle(OtekConstants.nuevaDireccion)
                    .navigationBarTitleDisplayMode(.inline)
                    
                    .toolbar {
                        
                        ToolbarItem(placement: .topBarLeading) {
                            Button(OtekConstants.cancelar) {
                                clearDireccion()
                                showDireccionSheet = false
                            }
                        }
                        
                        ToolbarItem(placement: .topBarTrailing) {
                            Button(OtekConstants.agregar) {
                                agregarDireccion()
                                clearDireccion()
                                showDireccionSheet = false
                            }
                            .bold()
                            .disabled(calle.isEmpty || ciudad.isEmpty || numeroCasa.isEmpty)
                        }
                    }
                }.onTapGesture {
                    self.direccionesFocused = nil
                }
            }
        }
    }
    
    private func agregarDireccion() {
        let direccion = Direccion(
            calle: calle,
            ciudad: ciudad,
            numeroCasa: numeroCasa
        )
        
        clienteDraft.direcciones.append(direccion)
    }
    
    private func clearDireccion() {
        calle = ""
        ciudad = ""
        numeroCasa = ""
    }
}


#Preview {
    ClienteForm()
        .environmentObject(ClienteViewModel())
}
