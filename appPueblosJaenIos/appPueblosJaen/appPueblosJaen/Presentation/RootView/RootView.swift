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
        switch rootViewModel.status {
            
        case .loading:
            ProgressView("Cargando pueblos...")
            
        case .loaded(let pueblos):
            List(pueblos) { pueblo in
                Text(pueblo.nombre)
            }
            
        case .empty:
            Text("No hay pueblos disponibles.")
            
        case .error(let error):
            VStack {
                Text("Algo salió mal")
                Text(error.errorDescription ?? "Error desconocido")
                    .font(.caption)
                    .foregroundColor(.red)
            }
        }
    }
}

#Preview {
    RootView()
}
