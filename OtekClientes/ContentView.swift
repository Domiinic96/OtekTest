//
//  ContentView.swift
//  OtekClientes
//
//  Created by Luis Santana on 13/4/26.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ClienteViewModel()
    var body: some View {
        
        MainView()
            .environmentObject(viewModel)
    }
}

#Preview {
    ContentView()
}
