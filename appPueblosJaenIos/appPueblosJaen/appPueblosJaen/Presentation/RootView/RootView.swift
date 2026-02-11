//
//  RootView.swift
//  appPueblosJaen
//
//  Created by Pablo Jesús Peragón Garrido on 11/2/26.
//

import SwiftUI

struct RootView: View {
    
    // MARK: - Properties
    @EnvironmentObject var rootViewModel: RootViewModel
    
    var body: some View {
        
        Group {
            switch rootViewModel.status {
                
            case .loading:
                VStack {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .tint(.purple)
                    Text("Cargando Pueblos de Jaén...")
                        .foregroundColor(.purple)
                }
                
            case .loaded(let pueblos):
                // Inyectamos los datos cargador en el HomeViewModel
                HomeView(homeViewModel: HomeViewModel(repository: rootViewModel.repository, pueblos: pueblos))
                
            case .empty:
                ContentUnavailableView("No hay datos", systemImage: "map", description: Text("No se encontraron pueblos en la base de datos."))
                
            case .error(let error):
                VStack(spacing: 16) {
                    Text("Error").font(.headline)
                        .foregroundStyle(.purple)
                    Text(error.errorDescription ?? "Error desconocido")
                        .foregroundStyle(.purple)
                    Button("Reintentar"){
                        Task { await rootViewModel.loadInitialData() }
                    }
                    .padding()
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
        }
        .task {
            await rootViewModel.loadInitialData()
        }
    }
}

#Preview {
    RootView()
}
