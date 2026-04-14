//
//  CustomTextField.swift
//  OtekClientes
//
//  Created by Luis Santana on 13/4/26.
//

import SwiftUI


struct CustomTextField: View {
    
    var icon: String
    var placeholder: String
    @Binding var text: String
    
    var body: some View {
        HStack(spacing: 12) {
            
            Image(systemName: icon)
                .foregroundStyle(.blue)
                .frame(width: 24)
            
            TextField(placeholder, text: $text)
                .textFieldStyle(.plain)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.03), radius: 2, x: 0, y: 10)
    }
}

#Preview {
    CustomTextField(icon: "mappin.and.ellipse", placeholder: "Calle", text: .constant("Juan Alejandro Ibarra"))
}
