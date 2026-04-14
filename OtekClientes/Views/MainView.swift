import SwiftUI

struct MainView: View {
    @EnvironmentObject var viewModel: ClienteViewModel
    var body: some View {
        NavigationStack {
            List {
                if viewModel.clientes.isEmpty {
                    Text("No hay clientes registrados")
                } else {
                    ForEach(viewModel.clientes) { cliente in
                        NavigationLink(
                            destination: ClienteDetailView(clienteDetail: cliente,showHeader: true)
                        ) {
                            VStack(alignment: .leading) {
                                Text(cliente.nombre).font(.headline)
                                Text(cliente.apellido).font(.subheadline)
                            }
                        }.swipeActions(edge: .leading) {
                            Button(role: .destructive) {
                                
                                withAnimation {
                                      viewModel.deleteCliente(cliente)
                                }
                                
                            } label: {
                                Label("Eliminar", systemImage: "trash")
                            }
                            
                        }
                        
                        
                    }                }
            }
            .navigationTitle("Clientes")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink("Agregar") {
                        ClienteForm()
                    }
                }
            }
            .toolbar {
                
                if !viewModel.clientes.isEmpty {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            withAnimation {
                                 viewModel.deleteAll()
                            }
                            
                        } label: {
                            Label("Eliminar todo", systemImage: "trash")
                            
                        }.tint(.red)
                        
                    }
                }
                
            }
            
        }.safeAreaInset(edge: .top) {
            if viewModel.showBanner {
                TopBannerView(
                    message: viewModel.bannerMessage,
                    isSuccess: viewModel.isSuccess
                )
                .transition(.move(edge: .top).combined(with: .opacity))
                .padding(.horizontal)
                .padding(.top, 8)
            }
        }
        .animation(.easeInOut, value: viewModel.showBanner)
    }
}

#Preview {
    MainView()
        .environmentObject(ClienteViewModel())
}
