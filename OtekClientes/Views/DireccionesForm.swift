//
//  DireccionesForm.swift
//  OtekClientes
//
//  Created by Luis Santana on 13/4/26.
//

import SwiftUI

struct DireccionesForm: View {
    @Binding var calle: String
    @Binding var ciudad: String
    @Binding var numeroCasa: String
    var body: some View {
        
        
        HStack(alignment:.center, spacing: 20) {
            Text("Agregar Direcciones")
                .font(.headline)
        }.padding(.top, 20)
        
        
        VStack {
            CustomTextField(icon: "mappin.and.ellipse", placeholder: "Calle", text: $calle)
            CustomTextField(icon: "house.fill", placeholder: "Numero casa/apto", text: $numeroCasa)
            CustomTextField(icon: "building.2", placeholder: "Ciudad", text: $ciudad)
        }.padding(20)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Direccion del cliente")
                }
            }
    }
}

#Preview {
    DireccionesForm(calle: .constant("23"), ciudad: .constant("Santo Domingo"), numeroCasa: .constant("23"))
}
