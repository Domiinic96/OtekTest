//
//  TopBannerView.swift
//  OtekClientes
//
//  Created by Luis Santana on 14/4/26.
//

import SwiftUI


struct TopBannerView: View {
    let message: String
    let isSuccess: Bool

    var body: some View {
        HStack {
            Image(systemName: isSuccess ? "checkmark.circle.fill" : "xmark.circle.fill")
            Text(message)
                .font(.subheadline)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(isSuccess ? Color.green.opacity(0.9) : Color.red.opacity(0.9))
        .foregroundColor(.white)
        .cornerRadius(12)
        .padding(.horizontal)
        .shadow(radius: 5)
    }
}
